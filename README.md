# claude-interview-toolkit

Repo-agnostic Claude Code slash commands: code review, coverage analysis, guardrail checks,
system-overview diagrams, and pre-code approach proposals. Each command discovers the target
repo's real toolchain (test runner, docs, Docker-or-not, HTTP-or-not) instead of assuming one —
built after `sush-*` commands written for one project silently broke when reused on another.

## Commands

- `/sush-code-review [target]` — code review + toolchain-aware sanity check
- `/sush-change-full-review [target]` — code review + tests + sanity + security review + published artifact
- `/sush-coverage [full]` — critical (not percentage) test coverage analysis
- `/sush-guardrails` — check the repo against its own `GUARDRAILS.md`, propose new rules
- `/sush-system-overview [simple]` — publishes an architecture + request-journey diagram artifact
- `/sush-explain-approach <requirement>` — proposes an approach as a reviewable artifact, no code written
- `/sush-explain-code-change [file]` — plain-language explanation of the current uncommitted diff

## Setup

### Option A — global (your own machine, use in every repo automatically)

```bash
git clone https://github.com/tsushanth/claude-interview-toolkit.git
cd claude-interview-toolkit
./install.sh --global
```

Installs to `~/.claude/commands/`. Every Claude Code session in any repo on this machine now
has these commands — no per-project step, nothing to remember to do at interview time.

### Option B — local (drop into one specific repo, e.g. an unfamiliar sandbox/interview repo)

```bash
git clone https://github.com/tsushanth/claude-interview-toolkit.git /tmp/cit
/tmp/cit/install.sh --local /path/to/target-repo
```

Or, from inside the target repo already:

```bash
git clone https://github.com/tsushanth/claude-interview-toolkit.git /tmp/cit
/tmp/cit/install.sh --local
```

Installs to `<target-repo>/.claude/commands/`. Use this when you're on a machine/sandbox where
you don't control `~/.claude` (e.g. a provided cloud dev environment) or want the commands
scoped to just that repo.

### One-liner for a cold sandbox with no prior setup

```bash
git clone https://github.com/tsushanth/claude-interview-toolkit.git /tmp/cit && /tmp/cit/install.sh --local
```

Run from the target repo's root. Takes a few seconds; no build step, no dependencies beyond git.

## Why these work on repos they've never seen

Every command's "figure out how to run/check this project" step reads `package.json` `scripts`,
checks for a workspace config (`pnpm-workspace.yaml`/`turbo.json`/`lerna.json`), looks for
whichever of `README.md`/`CLAUDE.md`/`PROBLEM.md` actually exists, and only assumes Docker or
HTTP-route sanity checks if a `Dockerfile` or an HTTP framework is actually present. Nothing is
hardcoded to a specific file name or command from whatever project a command was last used in.

## Updating

Edit files under `commands/`, commit, push. Re-run `install.sh` (same mode) in any repo to pick
up changes — it just copies, so old copies aren't auto-updated until you re-run it.
