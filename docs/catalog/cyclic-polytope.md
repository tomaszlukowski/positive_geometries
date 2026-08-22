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

## Why it belongs here

Cyclic polytopes are the extremal case against which every other family
in this catalog can be measured: the
[Upper Bound Theorem](https://en.wikipedia.org/wiki/Upper_bound_theorem)
says no \(d\)-polytope with \(n\) vertices has a larger f-vector,
entrywise, than \(C(n,d)\)'s. Concretely, their canonical forms are
computed the same way as the [associahedron's](associahedron.md) and
[permutohedron's](permutohedron.md) — by triangulating and summing
[simplex forms](simplex.md#canonical-form) — since neighborliness gives
no shortcut to the canonical form itself, only to the face count.

## References

* B. Grünbaum, *Convex Polytopes*, 2nd ed. (Ziegler, ed.), Ch. 4 and 8.
* G. Ziegler, *Lectures on Polytopes*, Ch. 8 — Gale's evenness condition
  and the Upper Bound Theorem.
