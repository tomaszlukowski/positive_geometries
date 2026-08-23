# Birkhoff polytope

## Definition

The **Birkhoff polytope** \(B_n\) is the set of \(n \times n\) **doubly
stochastic matrices** — nonnegative real matrices in which every row and
every column sums to 1 — viewed as a subset of \(\RR^{n^2}\):

\[
B_n = \Big\lbrace X = (x_{ij}) \in \RR^{n^2} : x_{ij} \geq 0,\ \
\textstyle\sum_j x_{ij} = 1 \ \forall i,\ \ \sum_i x_{ij} = 1\ \forall j
\Big\rbrace.
\]

By the **Birkhoff–von Neumann theorem**, its vertices are exactly the
\(n!\) **permutation matrices** — every doubly stochastic matrix is a
convex combination of permutation matrices, and no permutation matrix is
itself such a combination of the others. Its dimension is \((n-1)^2\):
the \(2n\) row/column-sum equations cut down \(n^2\) ambient coordinates,
but only \(2n-1\) of them are independent (any one row sum is implied by
the rest), leaving \(n^2 - (2n-1) = (n-1)^2\).

## Properties

* Dimension \((n-1)^2\); \(n!\) vertices.
* **Not simple** for any \(n \geq 2\): at a permutation-matrix vertex, the
  facets through it are the \(x_{ij} \geq 0\) constraints for the
  \(n^2 - n\) entries the permutation leaves at 0 — always \(n-1\) *more*
  than the dimension \((n-1)^2\) (checked directly: \(n^2 - n -
  (n-1)^2 = n - 1\)). \(B_2\) (a segment) already has this: 2 facets meet
  at each vertex of a 1-dimensional polytope.
* A special case of the broader family of **transportation polytopes**
  (fixing row/column sums to values other than 1).
* Central to the **Sinkhorn / doubly-stochastic-matrix** literature (e.g.
  the Sinkhorn–Knopp algorithm) and to combinatorial optimization, where
  \(B_n\) is the linear-programming relaxation of the assignment problem.

## f-vector

Values computed directly (not derived by hand); \(n!\) vertices at every
\(n\), matching [Properties](#properties):

| \(d=(n-1)^2\) | \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) | \(f_5\) | \(f_6\) | \(f_7\) | \(f_8\) |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 2 | 2 | — | — | — | — | — | — | — | — |
| 4 | 3 | 6 | 15 | 18 | 9 | — | — | — | — | — |
| 9 | 4 | 24 | 240 | 978 | 1968 | 2176 | 1392 | 528 | 120 | 16 |

\(B_3\)'s and \(B_4\)'s facet counts (9 and 16) are exactly \(n^2\) — every
one of the \(x_{ij} \geq 0\) inequalities is facet-defining. \(B_2\) is the
one exception in this table: only 2 of its 4 such inequalities are
facet-defining (the other two are implied once dimension drops to 1),
checked directly rather than assumed to follow the same \(n^2\) pattern.

## Canonical form

\(B_n\) is not simple (see [Properties](#properties)), so the
[simplex's](simplex.md) and [permutohedron's](permutohedron.md#canonical-form)
one-term-per-vertex shortcut (Proposition 6.10) never applies to this
family, even at \(n=2\); the fully general formula does (F. Brown,
C. Dupont, *Positive geometries and canonical forms via mixed Hodge
theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202),
Proposition 6.7): at each vertex, sum over every non-broken-circuit
subset of the facets through it whose associated flag survives an
iterated boundary map. Checked directly against the defining
pole-structure property in
[sagemath/birkhoff.sage](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/birkhoff.sage)
for \(n=2,3\); see
[birkhoff_explorer.ipynb](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/birkhoff_explorer.ipynb)
for the term-by-term breakdown at every vertex.

**Volume conjecture.** The canonical form, evaluated at the centroid (in
a chart re-centered there), equals \(\pm\, d!\) times the volume of the
polytope's own projective dual taken at that same centroid — verified
numerically in the notebook above for \(n=2,3\) (see
[simplex.md](simplex.md#canonical-form) for why the reference point has
to be the centroid specifically).

**This family caps out earlier than almost any other on this site.**
\(n!\) vertex growth means \(B_4\) already has 24 vertices in a
9-dimensional, badly non-simple polytope; its canonical form alone was
measured to take about 80 seconds while building this page (against well
under a second for \(B_3\)), and triangulation enumeration at \(n=4\)
didn't complete in reasonable time at all. The f-vector and volume,
computed directly rather than through the canonical-form machinery, stay
cheap through \(n=4\) — see [f-vector](#f-vector) above.

## A note on the volume numbers

\(\mathrm{vol}(B_3) = 1/8\) and \(\mathrm{vol}(B_4) = 11/11340\) (computed
directly, Sage's own induced Euclidean measure on the polytope's affine
hull) match — exactly — the leading coefficients of Beck and Pixton's
Ehrhart polynomials \(H_3(t)\) and \(H_4(t)\) for these same polytopes
(M. Beck, D. Pixton, *The Ehrhart polynomial of the Birkhoff polytope*,
Discrete Comput. Geom. 30 (2003) 623–637), which is exactly what Ehrhart
theory predicts that coefficient equals: the volume relative to the
primitive sublattice of the polytope's own affine hull. This is **not**
the same normalization as the \(\mathrm{vol}(B_3) = 9/8\) figure quoted in
some places — that's Beck–Pixton's own separately-rescaled
\(n^{n-1}\times(\text{leading coefficient})\) table value, a different
quantity from the plain Ehrhart leading coefficient computed here.
Checked directly against their paper before writing this (not assumed) —
worth flagging explicitly, since it's an easy mismatch to fall into by
quoting a "known" volume without checking which convention it uses.

## Embeddings by dimension

Vertices in the reduced chart (dropping the \(2n-1\) redundant ambient
coordinates via `reduce_full_dim` — a genuine affine-hull projection,
unlike the single-coordinate drop `reduce_codim1` uses for the
[permutohedron](permutohedron.md#embeddings-by-dimension) and
[associahedron](associahedron.md#embeddings-by-dimension)):

=== "n = 2"
    the segment: \((0)\), \((1)\)

=== "n = 3"
    6 vertices (the \(3!\) permutation matrices of \(S_3\)):
    \((0,0,0,1)\), \((0,0,1,0)\), \((0,1,0,0)\), \((0,1,1,0)\),
    \((1,0,0,0)\), \((1,0,0,1)\)

## Verification notebook

Every claim on this page is checked computationally in
[`sagemath/birkhoff_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/birkhoff_explorer.ipynb) —
vertices, canonical form, dual, volume conjecture, triangulations, and
secondary polytope for \(n=2,3\); f-vector and volume only for \(n=4\).
See [Verification notebooks](../notebooks.md) for what's in it and how to
run it yourself.

## References

* G. Birkhoff, *Tres observaciones sobre el algebra lineal*, Univ. Nac.
  Tucumán Rev. Ser. A 5 (1946) 147–151 — the theorem identifying
  \(B_n\)'s vertices with permutation matrices.
* M. Beck, D. Pixton, *The Ehrhart polynomial of the Birkhoff polytope*,
  Discrete & Computational Geometry 30 (2003) 623–637 — the exact Ehrhart
  polynomials and volumes used to cross-check this page's own computed
  values (see [the note above](#a-note-on-the-volume-numbers)).
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.7, the general nbc-sum method behind the canonical form
  above.
