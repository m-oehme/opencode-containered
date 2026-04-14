#!/bin/bash
set -e

COMMAND="${1:-serve}"
shift || true

# Pass OPENCODE_ARGS if set
if [ -n "$OPENCODE_ARGS" ]; then
  set -- $OPENCODE_ARGS "$@"
fi

# Ensure hostname is set for external access
if [[ "$*" != *"--hostname"* ]]; then
  set -- "$@" --hostname 0.0.0.0
fi

exec opencode "$COMMAND" "$@"
