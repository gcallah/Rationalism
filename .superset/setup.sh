#!/usr/bin/env bash
# Prepare a fresh Superset workspace. Safe to re-run.
set -euo pipefail
cd "$(dirname "$0")/.."

# The makefiles need the AntiRats/utils submodule (html_checker.py, html_include.awk).
git submodule update --init --recursive

# Copy untracked env-style files from the main checkout, if there are any.
ROOT="${SUPERSET_ROOT_PATH:-}"
if [ -n "$ROOT" ] && [ "$(cd "$ROOT" && pwd -P)" != "$(pwd -P)" ]; then
  for f in .env .env.local; do
    if [ -f "$ROOT/$f" ] && [ ! -e "$f" ]; then
      cp "$ROOT/$f" "$f"
      echo "Copied $f from $ROOT"
    fi
  done
fi

echo "Workspace setup complete."
