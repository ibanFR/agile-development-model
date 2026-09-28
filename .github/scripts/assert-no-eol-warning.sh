#!/usr/bin/env bash
# Fails when a Structurizr tool's log warns about the cloud service end of life, which
# means the workspace depends on something hosted there, such as `theme default`.
# Guards the vendored theme against a revert.
#
# Usage: assert-no-eol-warning.sh <log-file>
set -euo pipefail

if grep -F "End of Life" "$1"; then
  echo "::error file=workspace.dsl::The workspace depends on the Structurizr cloud service, which reaches end of life on 30 September 2026"
  exit 1
fi
