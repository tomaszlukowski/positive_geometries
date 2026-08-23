# Hypersimplex

## Definition

The **hypersimplex** \(\Delta(k,n)\), for \(1 \leq k \leq n-1\), is the
convex hull of all 0/1 vectors in \(\RR^n\) with exactly \(k\) ones:

\[
\Delta(k,n) = \conv\lbrace  e_S : S \subset \lbrace 1,\dots,n\rbrace ,\ |S| = k \rbrace ,
\qquad e_S = \sum_{i \in S} e_i.
\]

Equivalently, it is the slice \(\lbrace x \in [0,1]^n : \sum_i x_i = k\rbrace \) of
the [hypercube](hypercube.md). It is the **matroid polytope** of the
uniform matroid \(U_{k,n}\), and a member of the
[generalized permutohedron](generalized-permutohedra.md) family.

## Properties

* Dimension \(n-1\); \(\binom{n}{k}\) vertices.
* \(2n\) facets for \(1 < k < n-1\) — the same \(x_i \geq 0\) and
  \(x_i \leq 1\) inequalities that cut out the hypercube slice, all of
  which remain facet-defining in this range.
* \(\Delta(1,n)\) is the standard \((n-1)\)-[simplex](simplex.md), and by
  the symmetry \(\Delta(k,n) \cong \Delta(n-k,n)\) so is \(\Delta(n-1,n)\).
* \(\Delta(2,4)\) is combinatorially the **octahedron** — the
  3-dimensional [cross-polytope](cross-polytope.md) — a coincidence
  worth pointing out precisely because a general hypersimplex is *not* a
  cross-polytope; it stops coinciding with any family already in this
  catalog beyond this one case.
* Central to the positive Grassmannian: the positive part of the
  Grassmannian \(\mathrm{Gr}(k,n)\) projects onto \(\Delta(k,n)\), and the
  images of its positroid cells give a well-studied polyhedral
  subdivision of it.

## f-vector

\(f_0(\Delta(k,n)) = \binom{n}{k}\) (vertices) and, for \(1<k<n-1\),
\(f_{d-1}(\Delta(k,n)) = 2n\) (facets) — both stated already in
[Properties](#properties). Unlike the other families in this catalog,
the *intermediate* face counts don't reduce to a simple closed formula
in general (the face lattice of a hypersimplex is governed by matroid
subdivisions, not a product structure), so this site gives exact,
computed values for the \(k=2\) slice used below rather than a general
formula:

| \(d\) | \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) | \(f_5\) |
|---|---|---|---|---|---|---|---|
| 3 | 4 | 6 | 12 | 8 | — | — | — |
| 4 | 5 | 10 | 30 | 30 | 10 | — | — |
| 5 | 6 | 15 | 60 | 80 | 45 | 12 | — |
| 6 | 7 | 21 | 105 | 175 | 140 | 63 | 14 |

## Canonical form

\(\Delta(k,n)\) is simplicial but, for \(1<k<n-1\), **not simple**: at a
vertex \(e_S\), the facets through it are the \(x_i \geq 0\) and
\(x_i \leq 1\) inequalities for \(i \notin S\) and \(i \in S\)
respectively that happen to touch it, and there are more than \(d=n-1\)
of them in general (for \(\Delta(2,4)\), every vertex lies on 4 facets,
not 3 — the same non-simple structure as the
[octahedron](cross-polytope.md#canonical-form), which \(\Delta(2,4)\) is
combinatorially identical to). So the [simplex's](simplex.md) and
[permutohedron's](permutohedron.md#canonical-form) one-term-per-vertex
shortcut (Proposition 6.10) doesn't apply here; the fully general
formula does (F. Brown, C. Dupont, *Positive geometries and canonical
forms via mixed Hodge theory*,
[arXiv:2501.03202](https://arxiv.org/abs/2501.03202), Proposition 6.7):
at each vertex, sum over every **non-broken-circuit** subset of the
facets through it (a combinatorial condition from matroid theory on the
facets' own linear dependencies) whose associated flag survives an
iterated boundary map — collapsing to exactly one nbc set per vertex
automatically whenever the vertex happens to be simple, but potentially
several at a non-simple one, as here. Checked directly against the
defining pole-structure property in
[sagemath/general_canonical_forms.sage](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/general_canonical_forms.sage)
for \(\Delta(2,n)\), \(n=4,\dots,9\); see
[hypersimplex_explorer.ipynb](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/hypersimplex_explorer.ipynb)
for the term-by-term breakdown at every vertex (2 competing nbc terms
per vertex throughout \(\Delta(2,4)\), for instance).

**Volume conjecture.** The canonical form, evaluated at the centroid (in
a chart re-centered there), equals \(\pm\, d!\) times the volume of
\(\Delta(k,n)\)'s own projective dual taken at that same centroid — for
\(\Delta(2,4)\), \(3!\cdot\mathrm{Vol}(\text{dual}) = 6\cdot 16 = 96\),
matching the centroid value exactly (see the note on
[simplex.md](simplex.md#canonical-form) for why the reference point has
to be the centroid specifically).

## Dual and triangulations (verified for d = 3)

- **Dual**: f-vector \((1,8,12,6,1)\), combinatorially the
  [hypercube](hypercube.md) — as expected, since \(\Delta(2,4)\) is
  itself combinatorially the octahedron, and the two families are
  mutual duals.
- **Triangulations & secondary polytope**: **3** triangulations in
  total, all regular — secondary polytope of dimension 2 with 3
  vertices (the same numbers as the [octahedron](cross-polytope.md#dual-and-triangulations-verified-for-d-3),
  for the same reason).

## Embeddings by dimension

\(\Delta(k,n)\) is a two-parameter family; fixing \(k=2\) (the smallest
choice that isn't just the simplex, since \(\Delta(1,n)\) always is —
see [Properties](#properties)) gives a clean one-parameter sequence
indexed by dimension \(d = n-1\), vertices \(e_i + e_j\) for every pair
\(i<j\):

=== "d = 3"
    \(\Delta(2,4)\), the octahedron: \((1,1,0,0)\),
    \((1,0,1,0)\), \((1,0,0,1)\), \((0,1,1,0)\), \((0,1,0,1)\),
    \((0,0,1,1)\)

=== "d = 4"
    \(\Delta(2,5)\): \((1,1,0,0,0)\), \((1,0,1,0,0)\), \((1,0,0,1,0)\),
    \((1,0,0,0,1)\), \((0,1,1,0,0)\), \((0,1,0,1,0)\), \((0,1,0,0,1)\),
    \((0,0,1,1,0)\), \((0,0,1,0,1)\), \((0,0,0,1,1)\)

=== "d = 5"
    \(\Delta(2,6)\): \((1,1,0,0,0,0)\), \((1,0,1,0,0,0)\),
    \((1,0,0,1,0,0)\), \((1,0,0,0,1,0)\), \((1,0,0,0,0,1)\),
    \((0,1,1,0,0,0)\), \((0,1,0,1,0,0)\), \((0,1,0,0,1,0)\),
    \((0,1,0,0,0,1)\), \((0,0,1,1,0,0)\), \((0,0,1,0,1,0)\),
    \((0,0,1,0,0,1)\), \((0,0,0,1,1,0)\), \((0,0,0,1,0,1)\),
    \((0,0,0,0,1,1)\)

Other \(k\) work identically — just every 0/1 vector with exactly \(k\)
ones instead of 2 — and are what the [f-vector](#f-vector) formula
\(\binom{n}{k}\) counts in general.

## Verification notebook

Every claim on this page is checked computationally in
[`sagemath/hypersimplex_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/hypersimplex_explorer.ipynb) —
vertices, canonical form, and dual for \(\Delta(2,n)\), \(n=4\) through
\(9\); the volume conjecture for \(n=4\) through \(7\) only (it needs a
second, costlier computation); triangulations and the secondary
polytope for \(n=4\) and \(5\) only. See
[Verification notebooks](../notebooks.md) for what's in it and how to
run it yourself.

## References

* A. Postnikov, *Permutohedra, Associahedra, and Beyond*,
  [arXiv:math/0507163](https://arxiv.org/abs/math/0507163).
* A. Postnikov, D. Speyer, L. Williams, *Matching Polytopes,
  Toric Geometry, and the Non-negative Part of the Grassmannian*,
  [arXiv:0706.2501](https://arxiv.org/abs/0706.2501).
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.7, the general nbc-sum method behind the canonical form
  above.
