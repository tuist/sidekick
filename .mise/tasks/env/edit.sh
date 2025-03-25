#!/usr/bin/env bash
# mise description="Edit the .env file"

set -eo pipefail

SOPS_AGE_KEY_FILE=~/.config/mise/runforge-age.txt sops edit .env.json
