#!/usr/bin/env bash
# Fails when the generated site has lost documentation the workspace declares.
#
# Expectations are derived from the sources, not hardcoded: every documentation chapter
# in site/ must have a page titled with its heading that also carries the opening of its
# text, and every ADR in adrs/ must have its own numbered decision page carrying its
# heading. Guards the regression that ruled out the consolidated tooling's static export,
# which dropped all documentation and exited 0.
#
# The title alone is not enough: the first chapter's heading is also the software system's
# name, so the software system page carries the same title without the chapter's text.
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

# First line of the text after the heading, cut before any Markdown markup or character
# the page may render differently, so it can be matched verbatim in the generated HTML.
opening() {
  { sed -n '2,$p' "$1" | grep -m1 -vE '^[[:space:]]*($|[#!<>|`*+-]|[0-9]+\.[[:space:]])' || true; } |
    sed -E 's/^[[:space:]]+//; s/[^A-Za-z0-9 ,.:;()-].*//; s/[[:space:]]+$//'
}

# Whether any page titled with the heading, standalone or before the site name, has the text.
has_page() {
  local title="$1" text="$2" page
  while IFS= read -r page; do
    if grep -qF "$text" "$page"; then return 0; fi
  done < <(grep -rlF --include=index.html -e "<title>${title} |" -e "<title>${title}</title>" "$site")
  return 1
}

fail() {
  echo "::error file=$1::$2"
  missing=$((missing + 1))
}

for chapter in site/*.md; do
  chapters=$((chapters + 1))
  title="$(heading "$chapter")"
  text="$(opening "$chapter")"
  if [ -z "$title" ]; then
    fail "$chapter" "Documentation chapter has no heading to look for"
  # A few words could appear on any page, such as the software system's, and reopen the gap.
  elif [ "$(echo "$text" | wc -w)" -lt 4 ]; then
    fail "$chapter" "Documentation chapter's opening line has too few plain words to look for: \"${text}\""
  elif ! has_page "$title" "$text"; then
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
