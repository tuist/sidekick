#!/usr/bin/env bash
#MISE description="Creates a Linux release of the agent"

set -eo pipefail

(cd agent && MIX_ENV=prod BURRITO_TARGET=linux mix release --overwrite)
