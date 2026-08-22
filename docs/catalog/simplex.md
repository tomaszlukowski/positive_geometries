# Simplex

## Definition

The **unit simplex** on \(n\) vertices is the convex hull of the standard
basis vectors,

\[
S_n^{(0)} = \conv\lbrace e_1, \dots, e_n\rbrace  \subset \RR^n,
\]

a polytope of dimension \(d = n-1\). Projectively, the **simplex**
determined by \(n\) points \(Z_1, \dots, Z_n \in \PP^{n-1}\) in general
position is

\[
S_n = \conv\lbrace Z_1, \dots, Z_n\rbrace .
\]

Every facet of \(S_n\) is itself a simplex on \(n-1\) of the \(Z_i\), so
the family is closed under taking boundary components — the simplex is
the simplest possible positive geometry after a point.

## Properties

* Dimension \(d = n - 1\).
* \(n\) vertices, \(\binom{n}{2}\) edges, and in general
  \(\binom{n}{k+1}\) faces of dimension \(k\).
* Every proper subset of vertices spans a face: the simplex is the
  polytope with the maximum possible number of faces for its vertex
  count, and its boundary complex is the full simplicial complex on
  \(n\) vertices.
* Self-dual.

## f-vector

\(f_k(S_n)\) is the number of \(k\)-dimensional faces of the
\((n-1)\)-simplex, \(f_k = \binom{n}{k+1}\) — Pascal's triangle,
[OEIS A007318](https://oeis.org/A007318).

| \(d\) | \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) | \(f_5\) |
|---|---|---|---|---|---|---|---|
| 1 | 2 | 2 | — | — | — | — | — |
| 2 | 3 | 3 | 3 | — | — | — | — |
| 3 | 4 | 4 | 6 | 4 | — | — | — |
| 4 | 5 | 5 | 10 | 10 | 5 | — | — |
| 5 | 6 | 6 | 15 | 20 | 15 | 6 | — |
| 6 | 7 | 7 | 21 | 35 | 35 | 21 | 7 |

## Generating functions

Summing \(k\) from \(0\) to \(d-1 = n-2\), matching the table row for
each \(n\) exactly (see the [convention note](../theory/f-vectors.md)):

\[
f(x, y) = \sum_{n \geq 2} x^n \sum_{k=0}^{n-2} \binom{n}{k+1} y^k
= \frac{x}{(1-x)(1 - x - xy)} - \frac{x}{1-xy},
\]

\[
\tilde f(x, y) = \sum_{n \geq 2} \frac{x^n}{n!} \sum_{k=0}^{n-2} \binom{n}{k+1} y^k
= \frac{e^{x(1+y)} - e^{x} - e^{xy} + 1}{y}.
\]

## Canonical form

For the projective simplex \(S_n = \conv\lbrace Z_1,\dots,Z_n\rbrace \), with
\(Y \in \PP^{n-1}\) the integration variable and \(\br{\cdot}\) the
bracket of \(n\) points in \(\PP^{n-1}\) (a maximal minor of their
homogeneous coordinates),

\[
\Omega(S_n) = \frac{\br{Z_1 \cdots Z_n}^{\,n-1}\, \br{Y\, d^{n-1}Y}}
{(n-1)! \; \br{Y Z_1 \cdots Z_{n-1}}\, \br{Y Z_2 \cdots Z_n} \cdots \br{Y Z_n Z_1 \cdots Z_{n-2}}},
\]

the denominator running cyclically over the \(n\) facets. In the affine
chart of the unit simplex, with \(y_1, \dots, y_n\) the barycentric-type
coordinates dual to the vertices,

\[
\Omega(S_n^{(0)}) = \frac{\br{Y\, d^{n-1}Y}}{y_1 y_2 \cdots y_n},
\]

manifestly with a simple pole on each of the \(n\) facets \(\lbrace y_i = 0\rbrace \).

## Embeddings by dimension

Vertices of \(S_n^{(0)}\) in the reduced affine chart the canonical form
above is stated in (\(y_1,\dots,y_d\) independent, \(y_{d+1} =
1-\sum_i y_i\) implicit) — always the \(d+1\) standard basis vectors of
\(\RR^{d+1}\), written in that chart:

=== "d = 1"
    \(n = 2\): \((1)\), \((0)\)

=== "d = 2"
    \(n = 3\): \((1,0)\), \((0,1)\), \((0,0)\)

=== "d = 3"
    \(n = 4\), the tetrahedron: \((1,0,0)\), \((0,1,0)\),
    \((0,0,1)\), \((0,0,0)\)

    Volume \(1/6\). The canonical form above was independently
    re-derived from this embedding in SageMath (summing the general
    bracket formula, here trivial since the simplex is its own only
    triangulation) and matches, up to the overall orientation sign
    built into the definition — see
    [verification/results/simplex.md](https://github.com/tomaszlukowski/positive_geometries/blob/main/verification/results/simplex.md)
    for the full computation.

=== "d = 4"
    \(n = 5\): \((1,0,0,0)\), \((0,1,0,0)\), \((0,0,1,0)\),
    \((0,0,0,1)\), \((0,0,0,0)\)

=== "d = 5"
    \(n = 6\): \((1,0,0,0,0)\), \((0,1,0,0,0)\), \((0,0,1,0,0)\),
    \((0,0,0,1,0)\), \((0,0,0,0,1)\), \((0,0,0,0,0)\)

=== "d = 6"
    \(n = 7\): \((1,0,0,0,0,0)\), \((0,1,0,0,0,0)\), \((0,0,1,0,0,0)\),
    \((0,0,0,1,0,0)\), \((0,0,0,0,1,0)\), \((0,0,0,0,0,1)\),
    \((0,0,0,0,0,0)\)

## References

* N. Arkani-Hamed, Y. Bai, T. Lam, *Positive Geometries and Canonical
  Forms*, [arXiv:1703.04541](https://arxiv.org/abs/1703.04541), §3.
* [OEIS A007318](https://oeis.org/A007318) — Pascal's triangle.
