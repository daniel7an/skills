---
name: interview
description: Interview the user with AskUserQuestion to pin down intent and fill the gaps before any work starts.
disable-model-invocation: true
---

Interview the user about the topic they named. Do not start the work. Your only
job is to understand what they actually want.

The topic is whatever follows the command. If nothing follows it, ask what the
topic is.

## Before you ask

Find the answers you can find yourself. Read the files, the logs, the git
history, the existing config. Never ask what the repo already tells you.

Then write down the gaps that are left: the things only the user can answer, and
the places where two readings of the request lead to different work.

## The questions

Ask with the AskUserQuestion tool, never as plain text in your reply.

- Ask in rounds of at most 3 or 4 questions. Later rounds use the earlier
  answers, so do not front-load every question into the first round.
- One question per real decision. Drop any question whose answer would not
  change what you do.
- Put the recommended option first and mark it "(Recommended)".
- Give every option one line that says what happens if the user picks it.
- Set multiSelect when the options are not exclusive.
- Put the tradeoff in the question text, so the user can answer in their own
  words instead of picking an option.
- Use a preview when the options are concrete artifacts the user should compare:
  a layout, a code shape, a file structure.

These gaps usually decide the work, so cover the ones that are still open:

- The goal: what "done" looks like, and who reads or runs the result.
- The scope: what is in, and what stays untouched.
- The inputs: which files, datasets, hosts, models, or accounts.
- The constraints: time, cost, what must not break, what cannot be undone.
- The output: a file, a patch, a page, a report, a run.
- The unknowns you hit while reading: anything the code left ambiguous.

Stop when the next question would not change the plan. Two or three rounds is
normal. Do not interrogate.

## The brief

Close with a short brief, in plain English:

- What the user wants, in one or two sentences.
- The decisions they made, one bullet each.
- The assumptions you still make, one bullet each.
- The first concrete step.

Then ask whether to start. Do not start until they say so.
