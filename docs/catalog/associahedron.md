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
* \(K_3\) is a point, \(K_4\) is a pentagon, \(K_5\) is the familiar
  3-dimensional associahedron with 9 facets (6 pentagons and 3 squares) —
  the shape of the [interactive model](#interactive-model) below.
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
particular physical meaning; its canonical form is then computed like
any polytope's, by triangulating and summing
[simplex forms](simplex.md#canonical-form) via
[additivity](../theory/canonical-forms.md#triangulation-and-additivity) —
there is no single-formula shortcut analogous to the simplex or
hypercube. A different, kinematics-based realization of the same
combinatorial polytope — the *kinematic associahedron* of Arkani-Hamed,
Bai, He and Yan — does have an explicit closed-form canonical form, equal
to the tree-level biadjoint \(\phi^3\) scattering amplitude; see
[Physics motivation](../theory/physics-motivation.md).

## Interactive model

<div class="polytope-viewer" data-shape="associahedron">
<span class="polytope-viewer__label">K5 (3-dimensional associahedron)</span>
<span class="polytope-viewer__hint">drag to rotate · scroll to zoom</span>
</div>

## References

* J.-L. Loday, *Realization of the Stasheff polytope*,
  Arch. Math. 83 (2004).
* N. Arkani-Hamed, Y. Bai, S. He, G. Yan, *Scattering Forms and the
  Positive Geometry of Kinematics, Color and the Worldsheet*,
  [arXiv:1711.09102](https://arxiv.org/abs/1711.09102).
* [OEIS A033282](https://oeis.org/A033282) — Kirkman–Cayley numbers.
* [OEIS A001003](https://oeis.org/A001003) — little Schröder numbers.
