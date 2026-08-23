# Hypercube

## Definition

The **unit \(n\)-cube** is the \(n\)-fold Cartesian product of the unit
interval,

\[
K_n^{(0)} = [0,1]^n \subset \RR^n,
\]

a polytope of dimension \(n\). As a positive geometry it is the
\(n\)-fold product of the interval \([0,1]\) with itself (see
[Products](../theory/canonical-forms.md#products)), which is why its
canonical form factorizes completely.

## Properties

* Dimension \(n\); \(2^n\) vertices, \(2^{n-1}n\) edges, \(3^n\) faces of
  every dimension combined (the last a consequence of the identity
  below).
* Every facet is an \((n-1)\)-cube: fixing one coordinate to \(0\) or
  \(1\) gives \(2n\) facets.
* Dual to the [cross-polytope](cross-polytope.md).
* Simple polytope: every vertex lies on exactly \(n\) facets.

## f-vector

\[
f_k(K_n^{(0)}) = 2^{n-k} \binom{n}{k},
\]

the number of ways to choose which \(k\) coordinates stay free and then
fix each remaining coordinate to \(0\) or \(1\) —
[OEIS A038207](https://oeis.org/A038207).

| \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) | \(f_5\) |
|---|---|---|---|---|---|---|
| 1 | 2 | — | — | — | — | — |
| 2 | 4 | 4 | — | — | — | — |
| 3 | 8 | 12 | 6 | — | — | — |
| 4 | 16 | 32 | 24 | 8 | — | — |
| 5 | 32 | 80 | 80 | 40 | 10 | — |
| 6 | 64 | 192 | 240 | 160 | 60 | 12 |

## Generating functions

Summing \(k\) from \(0\) to \(n-1\), matching the table row for each
\(n\) exactly (see the [convention note](../theory/f-vectors.md)); the
binomial theorem collapses the \(k=0,\dots,n\) sum, and the extra
\(k=n\) term (the cube itself) is then subtracted off:

\[
f(x,y) = \sum_{n \geq 1} x^n \sum_{k=0}^{n-1} \binom{n}{k} 2^{n-k} y^k
= \frac{1}{1 - x(y+2)} - \frac{1}{1-xy},
\]

\[
\tilde f(x,y) = \sum_{n \geq 1} \frac{x^n}{n!} \sum_{k=0}^{n-1}\binom{n}{k}2^{n-k}y^k = e^{x(y+2)} - e^{xy}.
\]

## Canonical form

With \(y_1, \dots, y_n\) the coordinates on \([0,1]^n\), the canonical
form is the product of \(n\) copies of the interval's
\(dy_i / y_i(y_i-1)\) (worked out on the
[canonical forms page](../theory/canonical-forms.md#worked-example-the-interval)):

\[
\Omega(K_n^{(0)}) = \frac{dy_1 \wedge \cdots \wedge dy_n}{\prod_{i=1}^n y_i \, (y_i - 1)},
\]

with a simple pole on each of the \(2n\) facets \(\lbrace y_i = 0\rbrace \) and
\(\lbrace y_i = 1\rbrace \).

## Embeddings by dimension

Vertices of \(K_d^{(0)} = [0,1]^d\) — every length-\(d\) 0/1 string:

=== "d = 1"
    \((0)\), \((1)\)

=== "d = 2"
    \((0,0)\), \((1,0)\), \((0,1)\), \((1,1)\)

=== "d = 3"
    all 8 points \((x,y,z) \in \lbrace 0,1\rbrace ^3\): \((0,0,0)\),
    \((1,0,0)\), \((0,1,0)\), \((1,1,0)\), \((0,0,1)\), \((1,0,1)\),
    \((0,1,1)\), \((1,1,1)\). Volume \(1\) — verified below.

=== "d = 4"
    all 16 points \((x_1,x_2,x_3,x_4) \in \lbrace 0,1\rbrace ^4\):
    \((0,0,0,0)\), \((1,0,0,0)\), \((0,1,0,0)\), \((1,1,0,0)\),
    \((0,0,1,0)\), \((1,0,1,0)\), \((0,1,1,0)\), \((1,1,1,0)\),
    \((0,0,0,1)\), \((1,0,0,1)\), \((0,1,0,1)\), \((1,1,0,1)\),
    \((0,0,1,1)\), \((1,0,1,1)\), \((0,1,1,1)\), \((1,1,1,1)\)

For \(d \geq 5\) the pattern is identical — all \(2^d\) length-\(d\)
0/1 strings — so this site stops listing them out explicitly here.

## Dual and triangulations (verified for d = 3)

For \(K_3^{(0)}\), computed independently in SageMath + TOPCOM — see
[`sagemath/`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/README.md)
for the current verification scripts and notebooks:

- **Dual**: the polar of the centered cube (vertices \(\lbrace \pm\tfrac12\rbrace ^3\))
  has vertices \((\pm2,0,0)\), \((0,\pm2,0)\), \((0,0,\pm2)\) — f-vector
  \((1,6,12,8,1)\), combinatorially the
  [cross-polytope](cross-polytope.md), confirming the duality claimed
  above.
- **Canonical form**: re-derived independently as a sum over vertices
  (F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202),
  Proposition 6.10 — valid since the cube is simple: one bracket term per
  vertex, no triangulation needed); matches the closed form above up to
  overall orientation sign.
- **Volume conjecture**: the canonical form, evaluated at the centroid
  (in a chart re-centered there), equals \(\pm\, n!\) times the volume
  of the cube's own projective dual taken at that same centroid —
  \(3!\cdot\mathrm{Vol}(\text{dual}) = 6\cdot\tfrac{32}{3} = 64\), matching
  the centroid value exactly. See the note on
  [simplex.md](simplex.md#canonical-form) for why the reference point has
  to be the centroid specifically.
- **Triangulations & secondary polytope**: **74** triangulations of the
  cube in total (re-confirmed via SageMath's internal triangulation
  engine, not just the original TOPCOM pass). Their secondary polytope
  has dimension 4 and **74 vertices** — so every one of those 74
  triangulations is regular.

## References

* N. Arkani-Hamed, Y. Bai, T. Lam, *Positive Geometries and Canonical
  Forms*, [arXiv:1703.04541](https://arxiv.org/abs/1703.04541), §3.
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.10, the vertex-sum method used in the re-derivation
  above.
* [OEIS A038207](https://oeis.org/A038207).
