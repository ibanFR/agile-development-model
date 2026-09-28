#!/usr/bin/env bash
# Fails when the generated site has lost documentation the workspace declares.
#
# Expectations are derived from the sources, not hardcoded: every documentation chapter
# in site/ must have a page titled with its heading, and every ADR in adrs/ must have a
# decision page carrying its heading. Guards the regression that ruled out the
# consolidated tooling's static export, which dropped all documentation and exited 0.
#
# Usage: assert-site-content.sh [site-dir]   (default: build/site)
set -euo pipefail

site="${1:-build/site}"
missing=0

heading() {
  grep -m1 '^#' "$1" | sed -E 's/^#+[[:space:]]*//; s/[[:space:]]+$//'
}

for chapter in site/*.md; do
  title="$(heading "$chapter")"
  if ! grep -rqF --include=index.html -e "<title>${title} |" -e "<title>${title}</title>" "$site"; then
    echo "::error file=${chapter}::No page in the generated site for documentation chapter \"${title}\""
    missing=$((missing + 1))
  fi
done

for adr in adrs/*.md; do
  title="$(heading "$adr")"
  # <branch>/<software system>/decisions/<n>/; an unmatched glob makes grep fail, as it should.
  if ! grep -qsF "$title" "$site"/*/*/decisions/[0-9]*/index.html; then
    echo "::error file=${adr}::No decision page in the generated site for ADR \"${title}\""
    missing=$((missing + 1))
  fi
done

if [ "$missing" -gt 0 ]; then
  echo "${missing} documentation page(s) missing from ${site}"
  exit 1
fi
echo "All $(ls site/*.md | wc -l | tr -d ' ') chapters and $(ls adrs/*.md | wc -l | tr -d ' ') ADRs present in ${site}"
