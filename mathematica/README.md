# Mathematica verification

A second, independent implementation of the vertex embeddings,
f-vectors, volumes, and canonical forms published at
[tomaszlukowski.github.io/positive_geometries](https://tomaszlukowski.github.io/positive_geometries/) —
deliberately not a port of the [`verification/`](../verification/)
SageMath code, so the two don't share bugs. This folder is **not** part
of the website (it's outside `docs/`, so `mkdocs build` never touches
it).

## Contents

- **`PositiveGeometries.wl`** — the package: vertex generators for all
  seven catalog families, `FVector`, `PolytopeVolume`, a from-scratch
  triangulation routine (`PullingTriangulation`, a "pulling"/coning
  triangulation — a different algorithm than TOPCOM's placing
  triangulation used on the Sage side, which is itself a useful
  cross-check), `CanonicalFormDensity` (triangulation-additivity, same
  method as the Sage side but reimplemented independently), and
  `PolarDual`.
- **`VerificationNotebook.wl`** — plain Wolfram Language source with
  cell-style markers (`(* ::Section:: *)` etc.), so it **opens as a
  formatted notebook** in the Mathematica front end (File → Open) while
  also being directly runnable as a script. One section per family, with
  the n=1,2,3 (or family-appropriate: L, or n=d+3, etc. — noted in each
  section) instances ready to evaluate, each checking the computed
  f-vector and (where a clean closed form exists) volume against values
  worked out independently beforehand — see the comments in each section
  for exactly where each expected value comes from.

## Requirements

Mathematica 12 or later, or the free
[Wolfram Engine](https://www.wolfram.com/engine/) with `wolframscript`.
Nothing else — no paid add-ons.

## Running it

**In the Mathematica front end**: open `VerificationNotebook.wl`
directly (File → Open); it renders as a normal notebook. Evaluate
top to bottom (Evaluation → Evaluate Notebook), or step through cell by
cell. The last cell prints a summary of every check.

**Headlessly**:

```bash
wolframscript -file VerificationNotebook.wl
```

## What "verification" means here

Every expected value the notebook checks against was worked out
independently *before* writing the Mathematica code — from the site's
published closed-form combinatorial formulas, or from SageMath's exact
`Polyhedron.f_vector()` / `Polyhedron.volume()` calls (see
[`../verification/results/`](../verification/results/) and the f-vector
tables on each catalog page). Running this notebook checks a **third**,
independent computation — Mathematica's own `ConvexHullMesh` /
`MeshCellCount` — against those values. Agreement across three
independent methods (closed-form math, Sage/TOPCOM, Mathematica) is a
much stronger claim than any one of them alone.

I (the model that wrote this) don't have a Mathematica installation to
run this notebook myself — every function was written carefully and
cross-reasoned against the independently-verified Sage results (e.g.
`PullingTriangulation` on the cube produces exactly the same 6
tetrahedra TOPCOM found independently), but **this hasn't actually been
executed**. Treat a first run as genuinely checking the code, not just
the claims — if something fails, it's at least as likely to be a bug in
`PositiveGeometries.wl` as an error in the site's data. Please report
back (or just fix it) if anything doesn't check out.

## Scope note

This package covers f-vectors, embeddings, volumes, duals, and canonical
forms — it does *not* attempt regular-triangulation enumeration or
secondary polytopes; Mathematica has no equivalent of TOPCOM for that
(see the tool-choice discussion in
[`../verification/README.md`](../verification/README.md)). For that side
of things, use the Sage package.
