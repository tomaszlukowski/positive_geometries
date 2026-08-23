# Cyclohedron

## Definition

The **cyclohedron** \(W_n\) (also the Bott–Taubes polytope, or the type
B/C generalized associahedron) is the **graph-associahedron** of the
\(n\)-node cycle graph \(C_n\), following Devadoss's realization
(S. Devadoss, [arXiv:math/0612530](https://arxiv.org/abs/math/0612530)):
a **tube** of a graph \(G\) is a proper, nonempty, connected subset of
its nodes; two tubes are *compatible* if they are nested, or disjoint
with a disconnected union; a **tubing** is a set of pairwise-compatible
tubes. Faces of \(W_n\) correspond to tubings of \(C_n\), and its
vertices to the *maximal* tubings — those with \(n-1\) tubes. Devadoss
gives an explicit integer-coordinate realization for the vertex
associated to each maximal tubing, in \(\RR^n\) (a hyperplane slice, the
same convention as the [permutohedron](permutohedron.md) and
[associahedron](associahedron.md) on this site — see
[Embeddings by dimension](#embeddings-by-dimension)).

The same construction applied to other graphs recovers other families
in this catalog: the complete graph gives the permutohedron, and the
path graph gives an (independent, differently-coordinatized) realization
of the associahedron. Historically, \(W_n\) first appeared in Bott and
Taubes's work on knot invariants (1994), predating this graph-theoretic
description; it is also the classical **type B (equivalently type C)
generalized associahedron** of Fomin–Zelevinsky's cluster-algebra
classification — types B and C share a Dynkin diagram (differing only
in edge orientation, i.e. root-system duality), so they give the same
polytope, unlike the ordinary (type A) associahedron already on this
site.

## Properties

* Dimension \(n-1\); \(\binom{2n-2}{n-1}\) vertices (the **type B Catalan
  number**).
* Simple polytope, with \(n(n-1)\) facets.
* \(W_2\) is a segment, \(W_3\) is a hexagon — and coincides exactly
  with the order-3 [permutohedron](permutohedron.md), since the 3-node
  cycle graph and the complete graph on 3 nodes are the same graph.
  \(W_4\) is a 3-dimensional polytope with 20 vertices and 12 facets,
  genuinely distinct from any other family already in this catalog.
* A **generalized permutohedron** in the wider sense used across this
  catalog's [permutohedron](permutohedron.md), [associahedron](associahedron.md),
  and [hypersimplex](hypersimplex.md) pages, though not one arising from
  Postnikov's ordinary type-A submodular-function construction — see the
  [generalized permutohedra overview](generalized-permutohedra.md) for
  that narrower picture.

## f-vector

\(f_0(W_n) = \binom{2n-2}{n-1}\); the facet count \(f_{d-1}(W_n) =
n(n-1)\), \(d=n-1\), found directly from the computed f-vectors below
(not derived by hand) — [OEIS A000984](https://oeis.org/A000984), the
central binomial coefficients, since \(\binom{2n-2}{n-1} = \binom{2m}{m}\)
for \(m=n-1\).

| \(d\) | \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) |
|---|---|---|---|---|---|---|
| 1 | 2 | 2 | — | — | — | — |
| 2 | 3 | 6 | 6 | — | — | — |
| 3 | 4 | 20 | 30 | 12 | — | — |
| 4 | 5 | 70 | 140 | 90 | 20 | — |
| 5 | 6 | 252 | 630 | 560 | 210 | 30 |

Like the associahedron's, this f-polynomial doesn't collapse to a simple
closed rational generating function in two variables (same underlying
algebraic, not rational, singularity structure), so this site states it
row by row.

## Canonical form

\(W_n\) is simple, which is exactly what Brown–Dupont's vertex-sum
formula needs (F. Brown, C. Dupont, *Positive geometries and canonical
forms via mixed Hodge theory*,
[arXiv:2501.03202](https://arxiv.org/abs/2501.03202), Proposition 6.10):
at each vertex \(v\), exactly \(d\) facets \(f_1,\dots,f_d\) meet
(affine functions, \(f_i \geq 0\) on \(W_n\), \(f_i = 0\) exactly on the
facet through \(v\)), and

\[
\Omega(W_n) = (-1)^{d(d+1)/2} \sum_{v} \frac{|\det A_v|}
{f_1(y) \cdots f_d(y)}\; dy_1 \wedge \cdots \wedge dy_d,
\]

with \(A_v\) the \(d\times d\) matrix of the \(f_i\)'s linear
coefficients — one term per vertex, no triangulation needed. Checked
directly against the defining pole-structure property in
[sagemath/cyclohedron.sage](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cyclohedron.sage)
for \(n=2,3,4\); see
[cyclohedron_explorer.ipynb](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cyclohedron_explorer.ipynb)
for the term-by-term breakdown at every vertex, up to \(n=5\).

**Volume conjecture.** The canonical form, evaluated at the centroid (in
a chart re-centered there), equals \(\pm\, d!\) times the volume of
\(W_n\)'s own projective dual taken at that same centroid — for the
hexagon (\(n=3\)), verified numerically in the notebook above (see
[simplex.md](simplex.md#canonical-form) for why the reference point has
to be the centroid specifically).

## Embeddings by dimension

Vertices of \(W_n\) in the reduced chart (dropping the last of \(n\)
hyperplane-embedded coordinates — see
[permutohedron.md](permutohedron.md#embeddings-by-dimension) for the
same convention), via Devadoss's construction:

=== "n = 2"
    \((0)\), \((1)\)

=== "n = 3"
    the hexagon: \((0,1)\), \((0,2)\), \((1,0)\), \((1,2)\), \((2,0)\),
    \((2,1)\)

=== "n = 4"
    20 vertices: \((0,1,2)\), \((0,1,6)\), \((0,2,6)\), \((0,3,0)\),
    \((0,6,0)\), \((0,6,2)\), \((1,0,2)\), \((1,0,6)\), \((1,2,6)\),
    \((1,6,2)\), \((2,0,1)\), \((2,1,0)\), \((2,6,0)\), \((2,6,1)\),
    \((3,0,6)\), \((6,0,1)\), \((6,0,3)\), \((6,1,0)\), \((6,2,0)\),
    \((6,2,1)\)

## Verification notebook

Every claim on this page is checked computationally in
[`sagemath/cyclohedron_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cyclohedron_explorer.ipynb) —
vertices, canonical form, dual, and the volume conjecture for \(n=2\)
through \(5\); triangulations and the secondary polytope for \(n=2\)
and \(3\) only. See [Verification notebooks](../notebooks.md) for what's
in it and how to run it yourself.

## References

* S. Devadoss, *A realization of graph-associahedra*,
  [arXiv:math/0612530](https://arxiv.org/abs/math/0612530).
* R. Bott, C. Taubes, *On the self-linking of knots*, J. Math. Phys. 35
  (1994) 5247–5287.
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.10, the vertex-sum method behind the canonical form
  above.
* [OEIS A000984](https://oeis.org/A000984) — central binomial
  coefficients.
