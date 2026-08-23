# Cyclic polytope

## Definition

Fix \(n\) distinct real parameters \(t_1 < t_2 < \dots < t_n\) and the
**moment curve** \(\gamma(t) = (t, t^2, \dots, t^d) \in \RR^d\). The
**cyclic polytope** \(C(n,d)\) is the convex hull of the \(n\) points
\(\gamma(t_1), \dots, \gamma(t_n)\). Its combinatorial type does not
depend on the choice of the \(t_i\) — only on \(n\) and \(d\) — because
the face structure is governed entirely by **Gale's evenness condition**:
a subset of the \(n\) points spans a facet exactly when every pair of
indices *not* in the subset is separated by an even number of indices
that *are*.

## Properties

* Dimension \(d\); \(n\) vertices (every one of the defining points is a
  vertex, since the moment curve is in convex position).
* **Neighborly**: any \(\lfloor d/2 \rfloor\) of its vertices span a
  face. For even \(d\) this already forces the full \(\binom{n}{d/2}\)
  subsets of size \(d/2\) to be faces.
* Simplicial, and extremal: the **Upper Bound Theorem** (McMullen)
  states that \(C(n,d)\) maximizes every entry of the f-vector among all
  \(d\)-dimensional polytopes with \(n\) vertices — no simplicial or
  non-simplicial polytope with the same \((n,d)\) has more faces of any
  dimension.
* The number of facets is given by **Motzkin's formula**: for
  \(d = 2m\), \(f_{d-1}(C(n,d)) = \binom{n-m}{m} + \binom{n-m-1}{m-1}\);
  for \(d = 2m+1\), \(f_{d-1}(C(n,d)) = 2\binom{n-m-1}{m}\).

## f-vector

\(f_0(C(n,d)) = n\) and \(f_{d-1}(C(n,d))\) is given by Motzkin's
formula above; the intermediate entries follow from the simplicial
Dehn–Sommerville relations but aren't given a standalone closed form
here. Exact values for the \(n=d+3\) slice used below (computed
directly from the vertex sets, not derived by hand):

| \(d\) | \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) | \(f_5\) |
|---|---|---|---|---|---|---|---|
| 2 | 5 | 5 | 5 | — | — | — | — |
| 3 | 6 | 6 | 12 | 8 | — | — | — |
| 4 | 7 | 7 | 21 | 28 | 14 | — | — |
| 5 | 8 | 8 | 28 | 52 | 50 | 20 | — |
| 6 | 9 | 9 | 36 | 84 | 117 | 90 | 30 |

## Embeddings by dimension

\(C(n,d)\) is a two-parameter family; fixing \(n = d+3\) (the smallest
choice with any interesting facet structure) gives a one-parameter
sequence indexed by dimension, using the integer parameters
\(t = 1,\dots,n\) on the moment curve \(\gamma(t) = (t,t^2,\dots,t^d)\):

=== "d = 2"
    \(C(5,2)\): \((1,1)\), \((2,4)\), \((3,9)\), \((4,16)\), \((5,25)\)
    — any 5 points on a parabola, i.e. a convex pentagon.

=== "d = 3"
    \(C(6,3)\): \((1,1,1)\), \((2,4,8)\), \((3,9,27)\), \((4,16,64)\),
    \((5,25,125)\), \((6,36,216)\)

=== "d = 4"
    \(C(7,4)\): \((1,1,1,1)\), \((2,4,8,16)\), \((3,9,27,81)\),
    \((4,16,64,256)\), \((5,25,125,625)\), \((6,36,216,1296)\),
    \((7,49,343,2401)\)

=== "d = 5"
    \(C(8,5)\): \((1,1,1,1,1)\), \((2,4,8,16,32)\), \((3,9,27,81,243)\),
    \((4,16,64,256,1024)\), \((5,25,125,625,3125)\),
    \((6,36,216,1296,7776)\), \((7,49,343,2401,16807)\),
    \((8,64,512,4096,32768)\)

Coordinates grow fast (the \(d\)-th coordinate is \(t^d\)), which is
purely a cosmetic feature of the integer-parameter moment curve, not of
the polytope's combinatorics — any strictly increasing \(t_1 < \dots <
t_n\) gives the same combinatorial type (see [Definition](#definition)).

## Canonical form

Neighborliness gives no shortcut to the canonical form itself, only to
the face count — and cyclic polytopes are not simple for \(d \geq 4\)
(more than \(d\) facets can meet at a single vertex), so the
[simplex's](simplex.md) and [permutohedron's](permutohedron.md#canonical-form)
one-term-per-vertex shortcut (Brown–Dupont's Proposition 6.10) doesn't
apply in general — the fully general formula does (F. Brown, C. Dupont,
*Positive geometries and canonical forms via mixed Hodge theory*,
[arXiv:2501.03202](https://arxiv.org/abs/2501.03202), Proposition 6.7):
at each vertex, sum over every **non-broken-circuit** subset of the
facets through it (a combinatorial condition from matroid theory on the
facets' own linear dependencies) whose associated flag survives an
iterated boundary map. At \(d=3\), \(C(6,3)\) happens to still be simple
(it's combinatorially the octahedron, matching the vertex/edge/facet
counts in the [f-vector table](#f-vector) above); the non-simple
structure this general method is actually needed for shows up from
\(d=4\) on, where a single vertex of \(C(7,4)\) can lie on as many as 8
facets, with 5–6 nbc terms surviving there. Checked directly against the
defining pole-structure property in
[sagemath/general_canonical_forms.sage](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/general_canonical_forms.sage)
for \(d=2,3,4\); see
[cyclic_polytope_explorer.ipynb](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cyclic_polytope_explorer.ipynb)
for the term-by-term breakdown at every vertex.

**Volume conjecture.** The canonical form, evaluated at the centroid (in
a chart re-centered there), equals \(\pm\, d!\) times the volume of
\(C(n,d)\)'s own projective dual taken at that same centroid — for
\(C(6,3)\), \(3!\cdot\mathrm{Vol}(\text{dual}) = 6\cdot\tfrac{147}{1000}
= \tfrac{441}{500}\), matching the centroid value exactly (see the note
on [simplex.md](simplex.md#canonical-form) for why the reference point
has to be the centroid specifically).

## Dual and triangulations (verified for d = 3)

- **Dual**: f-vector \((1,8,12,6,1)\), combinatorially the
  [hypercube](hypercube.md) — following from \(C(6,3)\) itself being
  combinatorially the octahedron (see [Canonical form](#canonical-form)
  above).
- **Triangulations & secondary polytope**: **6** triangulations in
  total, all regular — secondary polytope of dimension 2 with 6
  vertices.

## Why it belongs here

Cyclic polytopes are the extremal case against which every other family
in this catalog can be measured: the
[Upper Bound Theorem](https://en.wikipedia.org/wiki/Upper_bound_theorem)
says no \(d\)-polytope with \(n\) vertices has a larger f-vector,
entrywise, than \(C(n,d)\)'s.

## Verification notebook

Every claim on this page is checked computationally in
[`sagemath/cyclic_polytope_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cyclic_polytope_explorer.ipynb) —
vertices, canonical form, dual, the volume conjecture, triangulations,
and the secondary polytope, for \(d=2\) through \(4\). See
[Verification notebooks](../notebooks.md) for what's in it and how to
run it yourself.

## References

* B. Grünbaum, *Convex Polytopes*, 2nd ed. (Ziegler, ed.), Ch. 4 and 8.
* G. Ziegler, *Lectures on Polytopes*, Ch. 8 — Gale's evenness condition
  and the Upper Bound Theorem.
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.7, the general nbc-sum method behind the canonical form
  above.
