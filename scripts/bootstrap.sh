#!/bin/bash
set -e

OS="$(uname -s)"
case "$OS" in
  Linux)
    exec bash "$(dirname "$0")/bootstrap-linux.sh" "$@"
    ;;
  Darwin)
    exec bash "$(dirname "$0")/bootstrap-mac.sh" "$@"
    ;;
  *)
    echo "Unsupported OS: $OS" >&2
    exit 1
    ;;
esac

