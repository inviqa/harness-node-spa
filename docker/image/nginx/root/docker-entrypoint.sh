#!/bin/sh
CONFIG="$(echo '{}' | jq -f -c /root/config.jq -)"
ESCAPED_CONFIG=$(printf '%s\n' "$CONFIG" | sed -e 's/[\/&]/\\&/g')

sed -i 's/%CONFIG%/'"$ESCAPED_CONFIG"'/' sr/share/nginx/html/index.html

exec "$@"
