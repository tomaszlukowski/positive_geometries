# Stellohedron

## Definition

The **stellohedron** is the **graph-associahedron** of the star graph
\(K_{1,n}\) (one center node joined to \(n\) leaves, no edges between
leaves), following the same construction as the
[cyclohedron](cyclohedron.md) — see that page for the precise
definitions of *tube*, *tubing*, and Devadoss's integer-coordinate
realization (S. Devadoss,
[arXiv:math/0612530](https://arxiv.org/abs/math/0612530)). Its
dimension is \(n\) (the star graph has \(n+1\) nodes total). It sits
alongside the [associahedron](associahedron.md), the
[cyclohedron](cyclohedron.md), and the [permutohedron](permutohedron.md)
as one of the classical named special cases of the general
graph-associahedron construction — see
[Graph associahedra](graph-associahedra.md) for how all four relate.

## Properties

* Dimension \(n\); \(\sum_{k=0}^{n} \dfrac{n!}{k!}\) vertices — the
  number of ways to arrange, in order, any number (including zero) of
  the \(n\) leaves ([OEIS A000522](https://oeis.org/A000522)), since a
  maximal tubing of the star graph amounts to choosing a subset of
  leaves and linearly ordering them around the center.
* Simple polytope.
* The stellohedron for \(n=1\) is a segment; for \(n=2\), a pentagon —
  numerically the same volume as the [associahedron](associahedron.md)'s
  own \(L=4\) pentagon (both are, combinatorially, *the* pentagon — the
  unique combinatorial type of a 5-vertex polygon), though the two
  realizations don't coincide as embedded polytopes.

## f-vector

\(f_0 = \sum_{k=0}^{n} n!/k!\) — [OEIS A000522](https://oeis.org/A000522),
"the total number of arrangements of a set with \(n\) elements". Values
computed directly (not derived by hand):

| \(d\) | \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) |
|---|---|---|---|---|---|---|
| 1 | 1 | 2 | — | — | — | — |
| 2 | 2 | 5 | 5 | — | — | — |
| 3 | 3 | 16 | 24 | 10 | — | — |
| 4 | 4 | 65 | 130 | 84 | 19 | — |
| 5 | 5 | 326 | 815 | 720 | 265 | 36 |

## Canonical form

The stellohedron is simple, which is exactly what Brown–Dupont's
vertex-sum formula needs (F. Brown, C. Dupont, *Positive geometries and
canonical forms via mixed Hodge theory*,
[arXiv:2501.03202](https://arxiv.org/abs/2501.03202), Proposition 6.10):
at each vertex \(v\), exactly \(d\) facets \(f_1,\dots,f_d\) meet
(affine functions, \(f_i \geq 0\), \(f_i = 0\) exactly on the facet
through \(v\)), and

\[
\Omega = (-1)^{d(d+1)/2} \sum_{v} \frac{|\det A_v|}
{f_1(y) \cdots f_d(y)}\; dy_1 \wedge \cdots \wedge dy_d,
\]

with \(A_v\) the \(d\times d\) matrix of the \(f_i\)'s linear
coefficients — one term per vertex, no triangulation needed. Checked
directly against the defining pole-structure property in
[sagemath/stellohedron.sage](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/stellohedron.sage)
for \(n=1,2,3\); see
[stellohedron_explorer.ipynb](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/stellohedron_explorer.ipynb)
for the term-by-term breakdown at every vertex, up to \(n=4\).

**Volume conjecture.** The canonical form, evaluated at the centroid (in
a chart re-centered there), equals \(\pm\, d!\) times the volume of the
stellohedron's own projective dual taken at that same centroid —
verified numerically in the notebook above (see
[simplex.md](simplex.md#canonical-form) for why the reference point has
to be the centroid specifically).

## Embeddings by dimension

Vertices in the reduced chart (dropping the last of \(n+1\)
hyperplane-embedded coordinates — same convention as the
[permutohedron](permutohedron.md#embeddings-by-dimension)), via
Devadoss's construction:

=== "n = 1"
    \((0)\), \((1)\)

=== "n = 2"
    the pentagon: \((0,1)\), \((0,2)\), \((1,0)\), \((1,2)\), \((3,0)\)

=== "n = 3"
    16 vertices: \((0,1,2)\), \((0,1,6)\), \((0,2,1)\), \((0,2,6)\),
    \((0,6,1)\), \((0,6,2)\), \((1,0,2)\), \((1,0,6)\), \((1,2,0)\),
    \((1,2,6)\), \((1,6,0)\), \((1,6,2)\), \((3,0,0)\), \((3,0,6)\),
    \((3,6,0)\), \((9,0,0)\)

## Verification notebook

Every claim on this page is checked computationally in
[`sagemath/stellohedron_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/stellohedron_explorer.ipynb) —
vertices, canonical form, dual, and the volume conjecture for \(n=1\)
through \(4\); triangulations and the secondary polytope for \(n=1\)
and \(2\) only. See [Verification notebooks](../notebooks.md) for what's
in it and how to run it yourself.

## References

* S. Devadoss, *A realization of graph-associahedra*,
  [arXiv:math/0612530](https://arxiv.org/abs/math/0612530).
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.10, the vertex-sum method behind the canonical form
  above.
* [OEIS A000522](https://oeis.org/A000522) — total number of
  arrangements of an \(n\)-set.
