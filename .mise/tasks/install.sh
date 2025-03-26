#!/usr/bin/env bash
#MISE description="Lints the project"

set -eo pipefail

(cd agent && mix deps.get)
pnpm -C docs/ install
