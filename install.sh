#!/usr/bin/env bash
# Installs the sush-* Claude Code commands into either:
#   --global   ~/.claude/commands/        (available in every repo, no per-project step)
#   --local    <target-repo>/.claude/commands/   (drops into one repo, e.g. an interview sandbox)
# Default target for --local is the current directory.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/commands"

MODE="${1:---global}"
TARGET_REPO="${2:-$(pwd)}"

case "$MODE" in
  --global)
    DEST="$HOME/.claude/commands"
    ;;
  --local)
    DEST="$TARGET_REPO/.claude/commands"
    ;;
  *)
    echo "Usage: ./install.sh [--global | --local [path-to-repo]]" >&2
    exit 1
    ;;
esac

mkdir -p "$DEST"
cp -v "$SRC"/*.md "$DEST/"

echo
echo "Installed $(ls "$SRC" | wc -l | tr -d ' ') commands to $DEST"
echo "Try: /sush-guardrails or /sush-system-overview in a Claude Code session in that repo."
