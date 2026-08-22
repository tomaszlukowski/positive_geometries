# Verification

Independent computational checks of the claims made on the
[catalog pages](../docs/catalog/simplex.md): f-vectors, canonical forms,
duals, volumes, and (where feasible) regular triangulations and
secondary polytopes. Built with [SageMath](https://www.sagemath.org/),
using its native `Polyhedron` class and its `PointConfiguration` class
(which wraps [TOPCOM](https://www.wm.uni-bayreuth.de/de/team/rambau_joerg/TOPCOM/)
for triangulation enumeration and secondary polytopes) — chosen over
Mathematica because neither Mathematica nor any other common CAS has
built-in equivalents of TOPCOM's triangulation/secondary-polytope
machinery; Sage gets the whole pipeline (embedding → dual → volume →
triangulations → canonical form) in one free, scriptable, reproducible
tool.

## Method

For each family, a script in `families/` does the following, in exact
rational (`QQ`) arithmetic throughout:

1. Build the vertex set for a representative low-dimensional instance
   (matching the one used in the site's interactive 3D model where there
   is one).
2. `Polyhedron(vertices=...)` → vertices, f-vector, volume — cross-checked
   against the table already on the catalog page.
3. `.polar()` → the dual polytope's vertices, f-vector, volume.
4. `PointConfiguration(...)` → one triangulation, the total count of
   triangulations, and `.secondary_polytope()`.
5. **The core check**: sum the [simplex canonical form](common/canonical_forms.sage)
   over every simplex in a triangulation (triangulation-additivity, see
   [theory/canonical-forms.md](../docs/theory/canonical-forms.md)),
   simplify symbolically, and compare against the closed form stated on
   the catalog page — **up to overall sign**, since the canonical form is
   only defined up to the choice of orientation of \(X_{\geq 0}\) (see
   [theory/positive-geometries.md](../docs/theory/positive-geometries.md)).
   Repeating the sum with a second, unrelated triangulation and checking
   it gives the *exact same* rational function (no sign ambiguity, since
   both use the same code) is the triangulation-independence check.

Results are written up in `results/<family>.md`, in human-readable form,
and cited from the corresponding catalog page once confirmed.

## Status

| Family | f-vector | Dual | Volume | Triangulations / secondary polytope | Canonical form |
|---|---|---|---|---|---|
| [Simplex](results/simplex.md) | ✅ | — (unbounded polar in this embedding) | ✅ | trivial (already a simplex) | ✅ matches, up to sign |
| [Hypercube](results/hypercube.md) | ✅ | ✅ octahedron | ✅ | ✅ 74 triangulations, all regular | ✅ matches, up to sign |
| Cross-polytope | — | — | — | — | — |
| Associahedron | — | — | — | — | — |
| Permutohedron | — | — | — | — | — |
| Hypersimplex | — | — | — | — | — |
| Cyclic polytope | — | — | — | — | — |

Remaining families follow the same script pattern (phase 2, not yet
done). Scale note: full triangulation/secondary-polytope enumeration is
combinatorially explosive — feasible at the sizes above and the other
families' interactive-viewer sizes, not necessarily much beyond.

## The volume conjecture — open

There's a real, literature-referenced relationship between a positive
geometry's canonical form and volume (of the polytope and/or its dual),
but this project deliberately hasn't stated a precise formula for it
yet — a first calibration attempt is written up at the end of
[results/hypercube.md](results/hypercube.md#open-item-the-volume-conjecture).
It works cleanly in \(d=1\) but needs real (not naive) projective
treatment to generalize; that's the next thing to work out here, in Sage,
before it goes on any catalog page.

## Running this

Requires SageMath (this was built and run against 10.9 from
conda-forge) with TOPCOM on `PATH` (Debian/Ubuntu's `topcom` package
installs binaries as `topcom-<name>`; symlink them to their unprefixed
names somewhere on `PATH`, e.g. `points2placingtriang`, for Sage's
`PointConfiguration` to find them).

```bash
cd verification
sage families/simplex.sage
sage families/hypercube.sage
```
