# 3. Omit autoLayout on the Components view

Date: 2026-09-20

## Status

Accepted

## Context

The Components view shows 18 elements on the site home page. Left-to-right ranking makes
it very wide, and it reads better top to bottom on a web page. Structurizr Lite is where the
model is authored, and the wide arrangement is wanted there.

The two surfaces render the model with different renderers. Structurizr Lite lays views out
itself and honours all four rank directions (`tb`, `bt`, `lr`, `rl`).
structurizr-site-generatr renders by exporting each view to PlantUML, and both PlantUML
exporters collapse the four directions to two: `LeftRight` becomes `left to right
direction`, everything else becomes `top to bottom direction`.

Neither tool offers a way to set a direction per surface. There is no `generatr.*` property
for layout; an extending workspace cannot redefine a view that already exists, only add one
under a different key, which would change the view's URL on the site; and `structurizr-cli
export` has no layout option.

One behaviour does differ between the surfaces. When a view declares no `autoLayout` at all,
both PlantUML exporters still write `top to bottom direction` explicitly, so the site is
top to bottom. Structurizr Lite instead treats such a view as manually laid out and restores
the element positions saved in `workspace.json`.

## Decision

The Components view declares no `autoLayout`. The site therefore renders it top to bottom,
and Structurizr Lite renders the manual arrangement saved locally.

`workspace.json` stays out of version control, as decided when it was removed in May 2025.

The other component views keep their explicit `autoLayout`, and are unaffected.

## Consequences

The Components view has no layout keyword, which reads like an oversight. This record is the
explanation; the DSL carries a comment pointing here.

The arrangement shown in Structurizr Lite is maintained by hand and lives only in the local
`workspace.json`. On a fresh clone that file is absent, so the view opens with its elements
stacked at the origin until someone uses the editor's auto-layout and saves the workspace.
The generated site is unaffected, because the PlantUML export path never reads element
positions.

The site loses the `ranksep` and `nodesep` values that an explicit `autoLayout` would have
supplied, so PlantUML's own spacing defaults apply to this one diagram.

Reverting is a one-line change: adding `autolayout tb` or `autolayout lr` back makes both
surfaces agree again, in whichever direction is chosen.
