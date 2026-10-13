# Project Workflow

## Guiding Principles

1. **The Plan is the Source of Truth:** All work must be tracked in `plan.md`.
2. **The Tech Stack is Deliberate:** Changes to the tech stack must be documented in `tech-stack.md` *before* implementation.
3. **Test-Driven & Validated:** Write validation tests and environment sanity checks before marking tasks done.
4. **User Experience First:** Every decision should prioritize smooth vibe coding and ease of use.
5. **Non-Interactive & CI-Aware:** Prefer non-interactive flags in automated scripts to avoid hanging terminals.

## Task Workflow

1. **Select Task:** Choose the next available task from `plan.md` in sequential order.
2. **Mark In Progress:** Before beginning work, edit `plan.md` and change the task from `[ ]` to `[~]`.
3. **Implementation & Tests:**
   - Implement the script, tool, or configuration.
   - Run verification and sanity tests to confirm it works as expected.
4. **Verification & Quality Gate:**
   - Confirm all scripts are executable, handle edge cases, and report clean diagnostics.
5. **Commit Code Changes:** Stage changes and commit with descriptive messages (e.g. `feat(setup): add WSL2 detection and installer script`).
6. **Update Plan:** Mark the task `[x]` with commit hash.

## Phase Completion Verification and Checkpointing Protocol

1. **Announce Protocol Start:** Inform the user when a phase is complete.
2. **Execute Automated Verification:** Run diagnostics and automated test suite.
3. **Manual Verification Steps:** Provide step-by-step instructions for the user to test the vibe coding flow.
4. **Checkpoint Commit:** Commit the phase milestone.

## Quality Gates
- [ ] Scripts run cleanly without uncaught exceptions
- [ ] Automated health checks / validation tests pass
- [ ] Clear documentation and instructions provided for each script
- [ ] No hardcoded secrets or credentials
