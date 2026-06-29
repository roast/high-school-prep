#!/usr/bin/env bash
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATUS=0

for t in test-env-check.sh test-templates.sh test-scaffold.sh test-build-pdf.sh; do
  echo "== Running $t =="
  bash "$SCRIPT_DIR/$t" || STATUS=1
done

exit $STATUS
