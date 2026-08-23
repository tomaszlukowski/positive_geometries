# Associahedron

## Definition

The **associahedron** \(K_L\) is the polytope whose vertices are the
binary trees with \(L\) leaves (equivalently, the ways to fully
parenthesize a product of \(L\) terms, or the triangulations of a convex
\((L{+}1)\)-gon), and whose edges connect trees related by a single
*rotation* — the local move that re-associates \((ab)c \leftrightarrow
a(bc)\). It has dimension \(d = L-2\).

**Loday's realization.** A concrete convex realization, due to Loday,
places a vertex for each planar binary tree \(T\) with \(L\) leaves at
the point \(M(T) \in \RR^{L-1}\) whose \(i\)-th coordinate (indexed by
the \(L-1\) internal nodes of \(T\), read left to right) is

\[
M(T)_i = a_i(T)\, b_i(T),
\]

the product of the number of leaves in the left and right subtrees below
the \(i\)-th internal node. All these points lie in the common
hyperplane \(\sum_i M(T)_i = \binom{L}{2}\), and their convex hull is
\(K_L\), independent of the tree \(T\) chosen.

## Properties

* Dimension \(d = L - 2\); \(\mathrm{Cat}(L-1) = \frac{1}{L}\binom{2L-2}{L-1}\)
  vertices, where \(\mathrm{Cat}\) is the Catalan numbers.
* Simple polytope: every vertex lies on exactly \(d\) facets, one for
  each of the \(d\) ways to add a single diagonal to the fully
  triangulated \((L{+}1)\)-gon.
* \(K_3\) is a segment, \(K_4\) is a pentagon, \(K_5\) is a
  3-dimensional associahedron with 9 facets (6 pentagons and 3 squares).
* A **generalized permutohedron**: see the
  [overview page](generalized-permutohedra.md) for how it sits alongside
  the [permutohedron](permutohedron.md) and [hypersimplex](hypersimplex.md)
  in that wider family.

## f-vector

Faces of \(K_L\) correspond to partial dissections of the
\((L{+}1)\)-gon: a face of dimension \(j\) is given by drawing
\(d - j\) non-crossing diagonals (leaving \(j\) undrawn), and the count
is the classical **Kirkman–Cayley number**

\[
f_j(K_L) = D\big(L{+}1,\ d-j\big), \qquad
D(p, k) = \frac{1}{k+1}\binom{p-3}{k}\binom{p+k-1}{k},
\]

the number of ways to dissect a convex \(p\)-gon into \(k+1\) cells with
\(k\) non-crossing diagonals — [OEIS A033282](https://oeis.org/A033282).
In particular \(f_0(K_L) = D(L{+}1, d) = \mathrm{Cat}(L-1)\), the vertex
count above.

| \(d\) | \((L{+}1)\)-gon | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) | \(f_5\) |
|---|---|---|---|---|---|---|---|
| 1 | square | 2 | — | — | — | — | — |
| 2 | pentagon | 5 | 5 | — | — | — | — |
| 3 | hexagon | 14 | 21 | 9 | — | — | — |
| 4 | heptagon | 42 | 84 | 56 | 14 | — | — |
| 5 | octagon | 132 | 330 | 300 | 120 | 20 | — |
| 6 | nonagon | 429 | 1287 | 1485 | 825 | 225 | 27 |

Summed across a row plus the excluded top face, this recovers the
**little Schröder numbers** ([OEIS A001003](https://oeis.org/A001003)):
e.g. for \(d=3\), \(14+21+9+1 = 45\), the number of dissections of a
hexagon by any number of non-crossing diagonals. Unlike the
[simplex](simplex.md), [hypercube](hypercube.md) and
[cross-polytope](cross-polytope.md), the associahedron's f-polynomial
does not collapse to a simple closed rational generating function in two
variables — it is genuinely algebraic, governed by the same singularity
structure as the Catalan generating function \(C(x) = \frac{1-\sqrt{1-4x}}{2x}\)
underlying \(D(p,k)\) itself — so this site states it row by row; see the
[data page](../data/f-vector-tables.md).

## Canonical form

Loday's coordinates realize \(K_L\) combinatorially but not with any
particular physical meaning, and there is no single-formula shortcut
analogous to the simplex or hypercube — but \(K_L\) is simple, which is
exactly what Brown–Dupont's vertex-sum formula needs (F. Brown,
C. Dupont, *Positive geometries and canonical forms via mixed Hodge
theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202),
Proposition 6.10): at each vertex \(v\), exactly \(d\) facets
\(f_1,\dots,f_d\) meet (affine functions, \(f_i \geq 0\) on \(K_L\),
\(f_i = 0\) exactly on the facet through \(v\)), and

\[
\Omega(K_L) = (-1)^{d(d+1)/2} \sum_{v} \frac{|\det A_v|}
{f_1(y) \cdots f_d(y)}\; dy_1 \wedge \cdots \wedge dy_d,
\]

with \(A_v\) the \(d\times d\) matrix of the \(f_i\)'s linear
coefficients — one term per vertex, no triangulation needed. Checked
directly against the defining pole-structure property in
[sagemath/vertex_sum_canonical_forms.sage](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/vertex_sum_canonical_forms.sage)
for \(L=3,4,5\); see
[associahedron_explorer.ipynb](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/associahedron_explorer.ipynb)
for the term-by-term breakdown at every vertex, up to \(L=6\).

A different, kinematics-based realization of the same combinatorial
polytope — the *kinematic associahedron* of Arkani-Hamed, Bai, He and
Yan — does have an explicit closed-form canonical form, equal to the
tree-level biadjoint \(\phi^3\) scattering amplitude; see
[Physics motivation](../theory/physics-motivation.md).

**Volume conjecture.** The canonical form, evaluated at the centroid (in
a chart re-centered there), equals \(\pm\, d!\) times the volume of
\(K_L\)'s own projective dual taken at that same centroid — for the
pentagon (\(L=4\)), the centroid value is \(-5\) and
\(2!\cdot\mathrm{Vol}(\text{dual}) = 2\cdot\tfrac{5}{2} = 5\), matching
up to the same overall orientation sign the canonical form is only ever
defined up to (see the note on [simplex.md](simplex.md#canonical-form)
for why the reference point has to be the centroid specifically).

## Embeddings by dimension

Loday's coordinates (see [Definition](#definition)) for the smallest
instances, one vertex per binary tree on leaves \(a, b, c, \dots\), with
the tree shown alongside its coordinate \(M(T)\):

=== "d = 1"
    \(L = 3\) leaves, in \(\RR^2\):

    * \(a(bc) \to (2, 1)\)
    * \((ab)c \to (1, 2)\)

=== "d = 2"
    \(L = 4\) leaves, in \(\RR^3\):

    * \(a(b(cd)) \to (3, 2, 1)\)
    * \(a((bc)d) \to (3, 1, 2)\)
    * \((ab)(cd) \to (1, 4, 1)\)
    * \((a(bc))d \to (2, 1, 3)\)
    * \(((ab)c)d \to (1, 2, 3)\)

=== "d = 3"
    \(L = 5\) leaves, in \(\RR^4\):

    * \(a(b(c(de))) \to (4, 3, 2, 1)\)
    * \(a(b((cd)e)) \to (4, 3, 1, 2)\)
    * \(a((bc)(de)) \to (4, 1, 4, 1)\)
    * \(a((b(cd))e) \to (4, 2, 1, 3)\)
    * \(a(((bc)d)e) \to (4, 1, 2, 3)\)
    * \((ab)(c(de)) \to (1, 6, 2, 1)\)
    * \((ab)((cd)e) \to (1, 6, 1, 2)\)
    * \((a(bc))(de) \to (2, 1, 6, 1)\)
    * \(((ab)c)(de) \to (1, 2, 6, 1)\)
    * \((a(b(cd)))e \to (3, 2, 1, 4)\)
    * \((a((bc)d))e \to (3, 1, 2, 4)\)
    * \(((ab)(cd))e \to (1, 4, 1, 4)\)
    * \(((a(bc))d)e \to (2, 1, 3, 4)\)
    * \((((ab)c)d)e \to (1, 2, 3, 4)\)

    14 vertices, matching the [f-vector table](#f-vector) row for
    \(d=3\).

Every coordinate is a product of two positive integers (leaves left ×
leaves right of that internal node), so — unlike the other families in
this catalog — the pattern isn't a simple closed formula to state for
general \(d\); it's generated the same way for any \(L\) by evaluating
\(M(T)\) on every binary tree with \(L\) leaves.

## References

* J.-L. Loday, *Realization of the Stasheff polytope*,
  Arch. Math. 83 (2004).
* N. Arkani-Hamed, Y. Bai, S. He, G. Yan, *Scattering Forms and the
  Positive Geometry of Kinematics, Color and the Worldsheet*,
  [arXiv:1711.09102](https://arxiv.org/abs/1711.09102).
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.10, the vertex-sum method behind the canonical form
  above.
* [OEIS A033282](https://oeis.org/A033282) — Kirkman–Cayley numbers.
* [OEIS A001003](https://oeis.org/A001003) — little Schröder numbers.
