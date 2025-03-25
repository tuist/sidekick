#!/usr/bin/env bash
# mise description="Encrypts the .env file"

set -eo pipefail

sops encrypt -i --age "age14ysrnz0jmkgasz7vc8l46lkd962xax2ny5pnq0596e5kpjvs2yzql76ymz" .env.json
