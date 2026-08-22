# Permutohedron

## Definition

The **permutohedron** of order \(n\) is the convex hull of all
permutations of \((1, 2, \dots, n)\), viewed as points in \(\RR^n\):

\[
\Pi_{n-1} = \conv\lbrace  (\sigma(1), \dots, \sigma(n)) : \sigma \in S_n \rbrace .
\]

All \(n!\) points lie in the hyperplane \(\sum_i x_i = \binom{n+1}{2}\),
so \(\Pi_{n-1}\) has dimension \(n-1\) — the subscript records this
directly. It is the founding example of a **generalized permutohedron**;
see the [overview page](generalized-permutohedra.md).

## Properties

* Dimension \(d = n-1\); \(n!\) vertices, one per permutation, with two
  vertices joined by an edge exactly when the permutations differ by a
  transposition of adjacent values.
* Simple polytope with \(2^n - 2\) facets, one for every proper nonempty
  subset \(S \subsetneq \lbrace 1,\dots,n\rbrace \), cut out by
  \(\sum_{i \in S} x_i \geq \binom{|S|+1}{2}\).
* \(\Pi_2\) is a hexagon, \(\Pi_3\) the truncated octahedron shown below —
  the unique polytope that tiles \(\RR^3\) by translation among the
  Archimedean solids.

## f-vector

Faces of \(\Pi_{n-1}\) are in bijection with **ordered set partitions**
of \(\lbrace 1,\dots,n\rbrace \): a face of dimension \(k\) corresponds to an ordered
partition into \(n-k\) nonempty blocks (one coordinate value per block).
Since an ordered partition into \(m\) blocks is equivalent to a
surjection onto an \(m\)-element ordered target,

\[
f_k(\Pi_{n-1}) = (n-k)!\, S(n, n-k),
\]

with \(S(n,m)\) the Stirling numbers of the second kind —
[OEIS A019538](https://oeis.org/A019538).

| \(d\) | \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) | \(f_5\) |
|---|---|---|---|---|---|---|---|
| 1 | 2 | 2 | — | — | — | — | — |
| 2 | 3 | 6 | 6 | — | — | — | — |
| 3 | 4 | 24 | 36 | 14 | — | — | — |
| 4 | 5 | 120 | 240 | 150 | 30 | — | — |
| 5 | 6 | 720 | 1800 | 1560 | 540 | 62 | — |
| 6 | 7 | 5040 | 15120 | 16800 | 8400 | 1806 | 126 |

## Generating function

Because \(f_0(\Pi_{n-1}) = n!\), face counts grow factorially in \(n\)
and there is no well-behaved *ordinary* generating function (see the
[remark on this](../theory/f-vectors.md#which-generating-function-is-the-natural-one)) —
only the exponential one is clean. Writing \(m = n-k\) and using the
classical exponential generating function
\(\sum_n m!\,S(n,m)\, x^n/n! = (e^x-1)^m\) for surjections:

\[
\tilde f(x,y) = \sum_{n \geq 2} \frac{x^n}{n!} \sum_{k=0}^{n-1} f_k(\Pi_{n-1})\, y^k
= \frac{y}{y + 1 - e^{xy}}.
\]

At \(y=1\) this is \(1/(2-e^x)\), the classical exponential generating
function for the **ordered Bell (Fubini) numbers**
\(1, 1, 3, 13, 75, 541, \dots\) — [OEIS A000670](https://oeis.org/A000670) —
counting all faces of every dimension at once.

## Canonical form

\(\Pi_{n-1}\) is a simple polytope with \(2^n-2\) facets but, unlike the
simplex or hypercube, no product or single-orbit structure to exploit —
its canonical form is computed the same way as the
[associahedron's](associahedron.md#canonical-form): triangulate and sum
[simplex forms](simplex.md#canonical-form) via
[additivity](../theory/canonical-forms.md#triangulation-and-additivity).

## Embeddings by dimension

Vertices of \(\Pi_{n-1}\) — every permutation of \((1,\dots,n)\):

=== "d = 1"
    \(n = 2\): \((1,2)\), \((2,1)\)

=== "d = 2"
    \(n = 3\), the hexagon: \((1,2,3)\), \((1,3,2)\), \((2,1,3)\),
    \((2,3,1)\), \((3,1,2)\), \((3,2,1)\)

=== "d = 3"
    \(n = 4\), the truncated octahedron shown below — 24 vertices, all
    permutations of \((1,2,3,4)\):

    \((1,2,3,4)\), \((1,2,4,3)\), \((1,3,2,4)\), \((1,3,4,2)\),
    \((1,4,2,3)\), \((1,4,3,2)\), \((2,1,3,4)\), \((2,1,4,3)\),
    \((2,3,1,4)\), \((2,3,4,1)\), \((2,4,1,3)\), \((2,4,3,1)\),
    \((3,1,2,4)\), \((3,1,4,2)\), \((3,2,1,4)\), \((3,2,4,1)\),
    \((3,4,1,2)\), \((3,4,2,1)\), \((4,1,2,3)\), \((4,1,3,2)\),
    \((4,2,1,3)\), \((4,2,3,1)\), \((4,3,1,2)\), \((4,3,2,1)\)

Vertex counts grow factorially (\(n!\); see the
[f-vector table](#f-vector)), so \(d \geq 4\) — already 120 vertices —
isn't listed out explicitly here: it's always "every permutation of
\((1,\dots,n)\)", generated the same way regardless of \(n\).

## Interactive model

<div class="polytope-viewer" data-shape="permutohedron">
<span class="polytope-viewer__label">Truncated octahedron (order-4 permutohedron)</span>
<span class="polytope-viewer__hint">drag to rotate · scroll to zoom</span>
</div>

## References

* R. Stanley, *Enumerative Combinatorics, Vol. 1* — ordered set
  partitions and Stirling numbers of the second kind.
* [OEIS A019538](https://oeis.org/A019538), [A000670](https://oeis.org/A000670).
