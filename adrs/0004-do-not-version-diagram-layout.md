# 4. Do not version diagram layout

Date: 2026-09-20

## Status

Accepted

## Context

The local viewer is an editor as well as a viewer. Dragging elements around a view and saving
writes the resulting element positions to `workspace.json`, a file the viewer generates
beside `workspace.dsl` and rewrites on every save. It is large — the copy removed in May 2025
was 1246 lines — and it churns on any authoring session, including sessions that only open a
view without changing the model.

Layout saved that way is per-machine in practice. Positions that read well on one screen at
one zoom level are not the positions someone else would have chosen, and two people editing
the same views produce conflicting diffs in a generated file that nobody reviews by reading.

The generated site never reads those positions. It renders each view through the PlantUML
export path, which lays views out itself, so the site is identical whether or not
`workspace.json` exists.

This sits against the diagrams-as-code practice the README describes, of versioning diagrams
and documentation in the same way as code. The model is versioned that way. Layout is not
part of the model: it is an editing convenience for one surface, produced by a tool rather
than written by hand.

This decision was already taken and is already in force. Commit 23929b3 ("Remove
workspace.json from version control", 17 May 2025) deleted the file, and 8e8c3ee, a minute
later, added `/workspace.json` to `.gitignore`. Neither commit message says more than what it
did, so no record of why has survived at all — which makes the absence look like an omission,
the kind of thing a reader would "fix" by committing the file back.

## Decision

`workspace.json` is not versioned. It stays in `.gitignore`, and diagram layout is treated as
a local authoring artefact rather than a source file.

The model itself — elements, relationships, views, and the `autoLayout` keywords that drive
automatic arrangement — lives in `workspace.dsl` and is versioned as usual.

## Consequences

On a fresh clone there is no saved layout. Views that declare `autoLayout` arrange themselves
in the local viewer and look right immediately. Views that declare none — currently the
Components view, see ADR-0003 — open with their elements stacked at the origin until someone
uses the editor's auto-layout and saves. That manual arrangement is then local to that clone
and is lost whenever the working copy is discarded.

Published documentation never depends on whose machine built it.

Diffs and reviews stay readable. No pull request carries a thousand-line churn in a generated
file, and no two authors conflict over positions.

Reverting is possible but costly: dropping the `.gitignore` entry and committing
`workspace.json` would restore shared layout at the price of that churn, and would make every
authoring session a source change.
