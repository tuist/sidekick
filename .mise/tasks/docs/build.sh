#!/usr/bin/env bash
#MISE description="Build the documentation"

set -eo pipefail

pnpm run -C docs build
