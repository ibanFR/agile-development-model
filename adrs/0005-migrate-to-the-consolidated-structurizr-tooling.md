# 5. Migrate to the consolidated Structurizr tooling

Date: 2026-09-28

## Status

Accepted

## Context

The model was authored and viewed locally with Structurizr Lite. Lite reached end of life:
its repository was archived on 2026-02-04, and it receives no further features, bug fixes or
security updates. The vendor replaced it with the `local` command of the consolidated
`structurizr/structurizr` image, which serves on the same port and reads the same mount point
as Lite. See https://docs.structurizr.com/eol and https://docs.structurizr.com/local.

The generated site is built by a third-party tool, Structurizr Site Generatr, which carries
its own copy of the Structurizr DSL parser. Moving local authoring to the consolidated tooling
raised the question of whether the site generator should go too, so that one tool — and one
parser — reads `workspace.dsl`. Two ways of doing that were tried against this repository's
actual workspace, not read from documentation:

- **The consolidated tooling's own static export.** `export -format static` produces the
  diagrams but drops all documentation. Exported against this workspace it wrote 8 views and
  `"documentation":{}` — 0 of the 7 chapters and 0 of the 2 ADRs the workspace then declared
  — and exited 0 without a warning. The JSON exporter from the same image carried all 7
  chapters and both ADRs, so the parser reads them; the static exporter simply does not
  serialize them. Adopting it would publish a site without the model's reasoning.

- **Feeding the site generator the consolidated tooling's JSON.** If the consolidated tooling
  parsed the DSL and the site generator only rendered the result, one parser would be left.
  That is not possible: the site generator DSL-parses whatever workspace it is given, and
  rejects JSON with `StructurizrDslParserException: Unexpected tokens (expected: workspace)
  at line 1`.

## Decision

Local authoring moves to the `local` command of the consolidated tooling, started from
`compose.yaml` with the image pinned. The zsh start script that ran Lite is removed.

Structurizr Site Generatr stays and keeps building the generated site in CI, pinned to an
explicit version.

## Consequences

The local viewer runs on a tool that still receives security updates, and starts with
`docker compose up`.

Two DSL parsers live in one repository: the consolidated tooling's, used locally, and the one
bundled in the site generator, used for the published site. DSL that one accepts may be
rejected by the other. When this was decided the gap was two patch releases — 6.2.3 in the
consolidated image, 6.2.1 in Site Generatr 1.6.0. It is currently wider: 1.6.0 changed the
geometry of every diagram, so CI is pinned back to 1.5.2 (#11), which bundles DSL parser
4.1.0. Adopting 1.6.0 and closing the gap again is tracked in #12.

The pull request check is what keeps the skew visible. Every pull request validates the
workspace with the consolidated tooling, pinned in `compose.yaml`, and then builds the site
with the pinned Site Generatr, so a change only one parser accepts fails before it reaches
`main`. The same check fails if the generated site is missing any documentation chapter or
ADR, guarding against a future pipeline change that drops documentation the way the static
export did.

Both pins are kept current by Dependabot, so the skew changes only through a reviewed commit.

The site generator going unmaintained — no longer tracking the upstream Structurizr parser —
is the trigger to revisit this decision. At that point the consolidated tooling's static
export should be tried again, and adopted only once it carries documentation.
