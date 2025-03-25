#!/usr/bin/env bash
#MISE description="Deploy the documentation"

set -eo pipefail

pnpm run -C docs build
wrangler pages deploy docs/.vitepress/dist --project-name runforge --branch main
