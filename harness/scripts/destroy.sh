#!/usr/bin/env bash

run docker-compose down --rmi local --volumes --remove-orphans

if [[ "$USE_MUTAGEN" = "yes" ]]; then
  run ws mutagen stop
  passthru ws mutagen rm
fi

ws cleanup built-images

run rm -f .my127ws/.flag-built
