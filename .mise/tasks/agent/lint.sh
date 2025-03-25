#!/usr/bin/env bash
#MISE description="Lints the agent"
#USAGE flag "-f --fix" help="Fix the fixable issues"

set -eo pipefail

if [ "$usage_fix" = "true" ]; then
  (cd agent && mix format)
else
    (cd agent && mix format --check-formatted)
    (cd agent && mix credo)

fi
