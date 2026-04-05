# Codex Reuse Kit

This repository is a compact starter kit for future Codex sessions.

It focuses on three things:

- giving Codex a clean task brief quickly
- capturing a workspace snapshot before making changes
- bootstrapping a Windows machine with the core tools that are commonly useful

## Layout

- `prompts/session-kickoff.md`: a reusable kickoff prompt for a new coding session
- `prompts/review-checklist.md`: a short review checklist for risky changes
- `templates/task-brief.md`: a fill-in template for handing over a task cleanly
- `scripts/install-core-tools.ps1`: installs a practical Windows toolchain with `winget`
- `scripts/workspace-snapshot.ps1`: prints a quick technical summary of the current workspace

## Suggested use

1. Run `scripts/workspace-snapshot.ps1` at the start of a task.
2. Paste the relevant parts into a new Codex session with `templates/task-brief.md`.
3. Use `prompts/session-kickoff.md` when the task needs a stronger initial instruction set.
4. Run `scripts/install-core-tools.ps1` on a fresh machine that is missing key tools.

## Notes

- The scripts are written for PowerShell on Windows.
- They try to be practical and conservative.
- The kit is intentionally small so it stays easy to trust and reuse.
