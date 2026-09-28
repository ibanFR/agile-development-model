#!/usr/bin/env bash
# Fails when the generated site has lost documentation the workspace declares.
#
# Expectations are derived from the sources, not hardcoded: every documentation chapter
# in site/ must have a page titled with its heading, and every ADR in adrs/ must have its
# own numbered decision page carrying its heading. Guards the regression that ruled out
# the consolidated tooling's static export, which dropped all documentation and exited 0.
#
# Known gap: the first chapter's heading is also the software system's name, so its title
# check is satisfied by the software system page too. The other chapters still catch a
# pipeline that drops documentation wholesale.
#
# Usage: assert-site-content.sh [site-dir]   (default: build/site)
set -euo pipefail

site="${1:-build/site}"
missing=0
chapters=0
adrs=0

heading() {
  { grep -m1 '^#' "$1" || true; } | sed -E 's/^#+[[:space:]]*//; s/[[:space:]]+$//'
}

fail() {
  echo "::error file=$1::$2"
  missing=$((missing + 1))
}

for chapter in site/*.md; do
  chapters=$((chapters + 1))
  title="$(heading "$chapter")"
  if [ -z "$title" ]; then
    fail "$chapter" "Documentation chapter has no heading to look for"
  elif ! grep -rqF --include=index.html -e "<title>${title} |" -e "<title>${title}</title>" "$site"; then
    fail "$chapter" "No page in the generated site for documentation chapter \"${title}\""
  fi
done

for adr in adrs/*.md; do
  adrs=$((adrs + 1))
  title="$(heading "$adr")"
  # 0003-some-title.md is published at <branch>/<software system>/decisions/3/.
  number=$((10#$(basename "$adr" | cut -d- -f1)))
  if [ -z "$title" ]; then
    fail "$adr" "ADR has no heading to look for"
  elif ! grep -qsF "$title" "$site"/*/*/decisions/"$number"/index.html; then
    fail "$adr" "No decision page ${number} in the generated site for ADR \"${title}\""
  fi
done

if [ "$missing" -gt 0 ]; then
  echo "${missing} documentation page(s) missing from ${site}"
  exit 1
fi
echo "All ${chapters} chapters and ${adrs} ADRs present in ${site}"
