# Branch Workflow

Use this workflow for every feature, fix, phase, or focused work item after the M0 baseline.

1. Start from an updated `main`.
2. Create a descriptive branch, for example `m1-foundation`.
3. Read the project-memory files required by `AGENTS.md`.
4. Record the branch context and plan in `docs/work/`.
5. Implement only the approved phase scope.
6. Run relevant checks and record exact results in progress files.
7. Commit the branch with a focused message.
8. Push the branch.
9. Create a pull request against `main`.
10. Merge the pull request after required checks/review expectations are satisfied.
11. Return to `main`, pull the merge commit, and stop before the next phase unless approved.

If PR automation is unavailable, push the branch and record the GitHub compare URL and manual merge instructions in the work log and final handoff.
