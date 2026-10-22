#!/usr/bin/env bash
# Stop the dev server started by run.sh, if it is still running.
cd "$(dirname "$0")/.."

PIDFILE="${TMPDIR:-/tmp}/superset-rationalism-${SUPERSET_WORKSPACE_NAME:-$(basename "$PWD")}.pid"
if [ -f "$PIDFILE" ]; then
  PID="$(cat "$PIDFILE")"
  if kill -0 "$PID" 2>/dev/null; then
    kill "$PID" && echo "Stopped dev server (pid $PID)."
  fi
  rm -f "$PIDFILE"
fi
exit 0
