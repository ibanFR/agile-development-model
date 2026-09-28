# 5. Migrate to the consolidated Structurizr tooling

Date: 2026-09-28

## Status

Accepted

## Context

The local viewer used to author the model was Structurizr Lite. Lite reached end of life:
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

The local viewer moves to the `local` command of the consolidated tooling, started from
`compose.yaml` with the image pinned. The zsh start script that ran Lite is removed. The
change landed in e044b6a.

Structurizr Site Generatr stays and keeps building the generated site in CI, pinned to an
explicit version. It is kept because it is the only option tried that publishes both the
diagrams and the documentation: the consolidated tooling cannot build that site on its own,
and cannot hand the site generator a parsed workspace to render instead.

## Consequences

The local viewer runs on a tool that still receives security updates, and starts with
`docker compose up`.

Two DSL parsers live in one repository: the consolidated tooling's, used by the local viewer,
and the one bundled in the site generator, used for the generated site. DSL that one accepts
may be rejected by the other. The skew accepted here is the one measured when this was
decided: two patch releases, 6.2.3 in the consolidated image against 6.2.1 in the site
generator 1.6.0.

At the time of writing the gap is a major version instead. The site generator 1.6.0 changed
the geometry of every diagram, so CI was pinned back to 1.5.2 (#11), which bundles DSL parser
4.1.0 — DSL the local viewer accepts may not parse in CI at all. That gap is not part of this
decision; it is tolerated only until #12 adopts 1.6.0 and brings both parsers back to the same
major version.

The pull request check is what keeps the skew visible. Every pull request validates the
workspace with the consolidated tooling, pinned in `compose.yaml`, and then builds the site
with the pinned Site Generatr, so a change only one parser accepts fails before it reaches
`main`. The same check fails if the generated site is missing any documentation chapter or
ADR, guarding against a future pipeline change that drops documentation the way the static
export did.

Either pin changes only through a reviewed pull request, so the skew never moves unseen.
Dependabot proposes new versions of the consolidated image; the site generator runs as a
workflow job container, which Dependabot does not watch, so its version is bumped by hand.

The site generator going unmaintained — no longer tracking the upstream Structurizr parser —
is the trigger to revisit this decision. At that point the consolidated tooling's static
export should be tried again, and adopted only once it carries documentation.
