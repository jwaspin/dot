#!/bin/bash
set -e

OS="$(uname -s)"
REPO_RAW_BASE="https://raw.githubusercontent.com/jwaspin/dot/main"
case "$OS" in
  Linux)
    if [ -f "$(dirname "$0")/bootstrap-linux.sh" ]; then
      exec bash "$(dirname "$0")/bootstrap-linux.sh" "$@"
    else
      curl -fsSL "$REPO_RAW_BASE/scripts/bootstrap-linux.sh" | bash -s -- "$@"
    fi
    ;;
  Darwin)
    if [ -f "$(dirname "$0")/bootstrap-mac.sh" ]; then
      exec bash "$(dirname "$0")/bootstrap-mac.sh" "$@"
    else
      curl -fsSL "$REPO_RAW_BASE/scripts/bootstrap-mac.sh" | bash -s -- "$@"
    fi
    ;;
  *)
    echo "Unsupported OS: $OS" >&2
    exit 1
    ;;
esac

