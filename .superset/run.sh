#!/usr/bin/env bash
# Serve the site locally on the first free port at or above $PORT (default 8000),
# so parallel workspaces don't collide.
set -euo pipefail
cd "$(dirname "$0")/.."

PORT="$(python3 - "${PORT:-8000}" <<'PY'
import socket, sys
port = int(sys.argv[1])
while True:
    with socket.socket() as s:
        try:
            s.bind(("127.0.0.1", port))
            break
        except OSError:
            port += 1
print(port)
PY
)"

PIDFILE="${TMPDIR:-/tmp}/superset-rationalism-${SUPERSET_WORKSPACE_NAME:-$(basename "$PWD")}.pid"
echo $$ > "$PIDFILE"
echo "Serving $(pwd) at http://127.0.0.1:$PORT/"
exec python3 -m http.server "$PORT" --bind 127.0.0.1
