# Hypercube — verification results

Computed with `verification/families/hypercube.sage`, SageMath 10.9 +
TOPCOM, exact rational arithmetic throughout.

## Instance

\(K_3^{(0)} = [0,1]^3\), the cube shown in the site's interactive model.

## Vertices

The 8 points \((x,y,z) \in \{0,1\}^3\).

## f-vector

\((1, 8, 12, 6, 1)\) — matches the site's table (8 vertices, 12 edges, 6
facets).

## Volume

\(\mathrm{Vol}(K_3^{(0)}) = 1\) — exact.

## Dual (polar) polytope

Computed from the *centered* cube (vertices at \(\{\pm 1/2\}^3\), since a
polar dual needs the origin in the interior):

- vertices: \((\pm 2, 0, 0)\), \((0, \pm 2, 0)\), \((0, 0, \pm 2)\)
- f-vector \((1, 6, 12, 8, 1)\) — 6 vertices, 12 edges, 8 facets
- volume \(32/3\)

Combinatorially this is the octahedron — confirms the
[cross-polytope page](../../docs/catalog/cross-polytope.md)'s claim that
the hypercube and cross-polytope are polar duals.

## Canonical form

Computed by triangulating the cube (TOPCOM found **74 triangulations in
total**) and summing simplex canonical forms via
[triangulation-additivity](../../docs/theory/canonical-forms.md#triangulation-and-additivity):

\[
\phi(y) = \frac{-1}{y_1(y_1-1)\, y_2(y_2-1)\, y_3(y_3-1)}
\]

- **Matches the site's closed form** \(1/\prod_i y_i(y_i-1)\) **up to
  overall orientation sign** (same reasoning as the simplex page). **PASS.**
- **Triangulation-independence check**: computed the same sum from a
  second, unrelated triangulation (the 37th of the 74 found) — the two
  computations agree **exactly**, with no sign ambiguity (both used the
  same code/orientation convention). **PASS.**

## Secondary polytope

`PointConfiguration(...).secondary_polytope()` for the 8 cube vertices:

- dimension 4
- f-vector \((1, 74, 152, 100, 22, 1)\)
- **74 vertices** — and TOPCOM separately found exactly 74 triangulations
  in total, so **every triangulation of the cube is regular**: the
  secondary polytope's vertices are in exact bijection with all of them,
  not just a subset. A clean, checkable structural fact, not assumed.

## Open item: the volume conjecture

The site's [f-vector theory page](../../docs/theory/f-vectors.md) and
catalog pages don't yet state a precise "canonical form → volume" limit,
deliberately: an attempt to calibrate it here (hand-derivation, before
any Sage code was written) confirmed a clean statement in \(d=1\) — for
the interval, substituting \(y = 1/t\) and expanding \(\Omega\) near
\(t=0\) reproduces \(\mathrm{Vol}([0,1]) = 1\) exactly as the leading
coefficient — but the naive generalization (inverting each \(y_i\)
independently) does **not** reproduce the triangle's area in \(d=2\); the
correct limit is evidently a genuinely projective one (a single point at
infinity along a direction, not \(d\) independent inversions), and
plausibly connects to the *dual* polytope's canonical form via a residue
at the hyperplane at infinity, which would explain why the volume and
the dual are natural to compute together. This needs proper symbolic
work in Sage before it's stated as fact anywhere — tracked as follow-up,
not asserted here.
