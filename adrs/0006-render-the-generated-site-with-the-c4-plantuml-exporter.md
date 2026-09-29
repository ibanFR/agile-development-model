# 6. Render the generated site with the C4-PlantUML exporter

Date: 2026-09-29

## Status

Accepted

Amends [ADR-0003](0003-omit-autolayout-on-the-components-view.md) and
[ADR-0005](0005-migrate-to-the-consolidated-structurizr-tooling.md)

## Context

ADR-0005 kept Structurizr Site Generatr for the generated site and accepted a patch-level skew
between its DSL parser and the local viewer's. At the time CI ran generatr 1.5.2, a major
version behind, and [#12](https://github.com/ibanFR/agile-development-model/issues/12) was to
close that gap by adopting 1.6.0, which bundles Structurizr 6.2.1 against the local viewer's
6.2.3.

Generatr 1.6.0 renders each view by exporting it to PlantUML, through one of two exporters
selected by the `generatr.site.exporter` view property: the Structurizr PlantUML exporter,
which this workspace had opted into, or the C4-PlantUML exporter, which is generatr's default.

With the Structurizr exporter, 1.6.0 regenerated every diagram with collapsed structure. Two
causes were found in the exporter and DSL sources, not guessed from the output:

- The exporter writes `ranksep` and `nodesep` as a fifth and a tenth of the view's
  `autoLayout` rank and node separation. The new DSL's defaults are 100 and 50, so a bare
  `autoLayout` becomes `ranksep 20` and `nodesep 5`, and labels collide.
- Relationship labels are no longer wrapped, and run on one line at the new 24px font.

Three responses were tried against this workspace:

- **Re-tuning the Structurizr exporter.** Spelling out `autoLayout <direction> 300 300` on
  every view, and wrapping labels with `plantuml.skinparams` `maxMessageSize=200`, restored
  the structure. It left the left-to-right views wider than under 1.5.2, made the Components
  PNG taller than PlantUML's 4096px default limit, so CI also had to raise
  `PLANTUML_LIMIT_SIZE`, and it changed spacing in the local viewer too.
- **Hiding the software system boundary** that 1.6.0 draws around containers in component
  views. The exporter writes that boundary unconditionally. Styling `Boundary:SoftwareSystem`
  white hides its outline and label, but PlantUML still reserves its space, so no diagram got
  smaller.
- **Switching to the C4-PlantUML exporter.** It writes a rank direction but never any
  spacing, and wraps labels itself. The structure came back with no per-view tuning.

The C4 exporter has two gaps of its own. Without `c4plantuml.tags` it ignores the workspace's
styles, so the grey `product` elements and dashed relationships are lost. And it always draws a
legend: it writes a `SHOW_LEGEND(...)` call whatever `c4plantuml.legend` says, because
C4-PlantUML reads that argument as whether to hide stereotypes, not whether to draw the legend.
With tags on, the legend lists every tag combination and dominates small views.

Generatr's own example workspace answered the same problem differently: it removed `autoLayout`
from every view. That suits a top-to-bottom workspace with short labels. Here five views are
left-to-right chains with long relationship labels, and removing `autoLayout` made them worse.

## Decision

The generated site is built with Structurizr Site Generatr 1.6.0, pinned in the workflow, using
the C4-PlantUML exporter:

- `generatr.site.exporter` is `c4`.
- `c4plantuml.tags` is `true`, so the workspace's element and relationship styles carry into
  the diagrams.
- `plantuml.includes` names `plantuml/hide-legend.puml`, which the exporter includes after the
  C4-PlantUML library. It redefines `SHOW_LEGEND` as a procedure that draws nothing.

Views keep their `autoLayout` keywords as they were, with the DSL's default separations.

## Consequences

The two DSL parsers are back to the skew ADR-0005 accepted: 6.2.1 in the site generator against
6.2.3 in the local viewer.

Diagrams on the site use C4-PlantUML's notation: square-cornered boxes, person icons instead of
the Structurizr person shape, and technology in italics. Colours come from the workspace's
styles and vendored theme through the tags. The local viewer is unaffected and keeps the
Structurizr look, so the two surfaces no longer look alike.

The site no longer depends on `autoLayout` separations for any view, because the C4 exporter
never writes spacing. What ADR-0003 recorded as true of the Components view alone — that
PlantUML's own spacing applies — is now true of every view.

Proportions are close to 1.5.2 for the component views and wider for the smaller ones, measured
as width over height of the generated SVG against 1.5.2:

| View                    | 1.5.2 | 1.6.0, C4 exporter |
|-------------------------|-------|--------------------|
| Context                 | 1.24  | 2.19               |
| Containers              | 0.43  | 0.74               |
| Components              | 0.24  | 0.40               |
| Align and Understand    | 3.46  | 3.31               |
| Behavior-Driven Dev.    | 2.29  | 2.32               |
| Domain-Driven Design    | 2.39  | 2.33               |
| Extreme Programming     | 2.53  | 2.68               |
| Lean Product Dev.       | 1.06  | 1.68               |

The Components PNG is 3285px tall, within PlantUML's default 4096px limit, so CI needs no size
override.

The legend override depends on C4-PlantUML's `SHOW_LEGEND` signature, and on generatr writing
`plantuml.includes` after the library. If a later generatr or C4-PlantUML changes either, the
legend returns or the build fails, which the pull request check surfaces.

Reverting to the Structurizr exporter is a property change, but it brings back the tuning
listed above: explicit separations on every view, label wrapping, and a raised PNG limit.
