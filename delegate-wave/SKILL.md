---
name: delegate-wave
description: Fan a job out to a wave of pi workers running DeepSeek on the opencode-go subscription, one Herdr pane per worker, so the heavy reading, searching and editing happens outside the main context. Use only when asked for it by name.
disable-model-invocation: true
---

# delegate-wave

Split a job across several `pi` workers. Each worker is a DeepSeek model on the
opencode-go subscription and runs in its own Herdr pane. The workers do the
reading, the searching and the editing. You keep the plan, the review and the
final answer.

The saving is context, not cleverness: the file contents never enter your
window. You read short reports instead of long files, and the worker tokens
come off the opencode-go subscription, not the Claude budget.

## When to use this

Only when the user asks. Triggers are `/delegate-wave`, "wave this out",
"delegate this to pi", "fan this out". Never start a wave on your own.

Good jobs:

- Survey many files or several subsystems at once.
- Apply the same mechanical change across many files.
- Write many similar tests or docstrings.
- Collect facts from parts of the repo you have not read yet.

Bad jobs:

- One small edit. The setup costs more than the wave saves.
- Work that needs your judgment on a single file.
- Eval runs, model serving and job rollovers. Those stay with you.

## Preflight

Run once per machine:

```sh
grep -q opencode-go ~/.pi/agent/auth.json && echo "wave ready"
```

If it is missing, the subscription key is in the `OC_GO_CC_API_KEY` shell
variable. Add it to `~/.pi/agent/auth.json` as
`{"opencode-go": {"type": "api_key", "key": "..."}}` and chmod the file to 0600.
Keep the key in that file, not in the environment, so it does not repoint other
tools that read `OPENCODE_API_KEY`.

## Step 1: cut the work into independent tasks

Workers write and edit with no approval prompt and no sandbox. Two workers on
the same file will overwrite each other. So partition by file: every file
belongs to exactly one worker. If two tasks need the same file, either merge
them into one worker or make the second one read-only.

Use 2 to 6 workers. Past 6 the panes are too small to watch, which is the whole
reason for using panes.

## Step 2: write one brief per worker

Write each brief to its own file in the scratchpad, then pass it with
`"$(cat ...)"`. This avoids quoting problems with long prompts.

A brief states four things: the exact files to read, the exact question or
change, the report path, and the limits.

End every brief with the report line. Pane output scrolls away, so the report
file is the real deliverable:

> Write your findings to `<scratchpad>/wave-<n>.md`.

Include these limits in every brief, word for word:

- Do not touch `evals/subsets/canonical/` or anything under `results/`.
- Do not run evals, start model servers, or launch long jobs.
- If a fact is not in the files, say you did not find it. Do not guess.

## Step 3: launch the wave

One pane per worker:

```sh
PANE=$(herdr pane split --current --direction right --ratio 0.4 --no-focus \
  | python3 -c "import sys,json;print(json.load(sys.stdin)['result']['pane']['pane_id'])")

herdr agent start wave-1 --kind pi --pane "$PANE" --timeout 60000 \
  -- --model opencode-go/deepseek-v4-flash
```

Then start every worker before waiting for any of them. `--until working`
returns as soon as the worker starts, so the wave runs at the same time instead
of one after another:

```sh
herdr agent prompt wave-1 "$(cat brief-1.md)" --wait --until working --timeout 20000
herdr agent prompt wave-2 "$(cat brief-2.md)" --wait --until working --timeout 20000
```

## Step 4: collect

Wait for each worker, then read its report file:

```sh
herdr agent wait wave-1 --until idle --until done --timeout 1800000
```

Read the report file first. Read the pane only when the report is missing or
looks wrong:

```sh
herdr agent read wave-1 --lines 60
```

## Step 5: verify before you use anything

Worker reports are claims, not facts. Before you put a number, a name or a
count into your answer, check it yourself with one grep or one file read. A
worker that lists 50 items correctly can still invent the 51st.

For edits, read the real change with `git diff`. Never trust a worker's summary
of its own edit.

## Step 6: close the panes

```sh
herdr pane close "$PANE"
```

Close every pane you opened. Leave a pane open only when the user asks to keep
watching that worker.

## Model choice

| Model | Use for |
|---|---|
| `opencode-go/deepseek-v4-flash` | Default. Reading, searching, listing, mechanical edits. 1M context. |
| `opencode-go/deepseek-v4-pro` | Harder reasoning, tricky refactors, an ambiguous spec. Same 1M context, slower. |

Set it per worker with `--model` at `herdr agent start`.

## Things that will bite you

- `--until working` proves the worker started, not that it finished. The report
  file on disk is the only real completion signal.
- Each pane holds its own pi session. To ask a follow up, prompt the same agent
  name again. Its context from the first prompt is still there.
- A worker inherits the pane working directory. Split the pane from a pane
  already sitting in the right repo, or pass `--cwd` to `herdr pane split`.
