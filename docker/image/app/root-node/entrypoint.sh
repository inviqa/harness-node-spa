#!/bin/bash

if [ "${1:-}" == "sleep" ]; then
    "$@"
else
    exec /sbin/tini su -- node -c "$(printf "%q " "${@:1}")"
fi
