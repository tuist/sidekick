#!/usr/bin/env bash
#MISE description="Test the agent"

set -eo pipefail

(cd agent && mix test)
