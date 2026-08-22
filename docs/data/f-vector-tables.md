# f-vector tables & generating functions

A single reference table for every family in the [catalog](../catalog/simplex.md).
\(f_k\) counts proper faces of dimension \(k\) only (see the
[convention note](../theory/f-vectors.md)); \(d\) is the dimension of the
member of the family shown. Each family's own catalog page has the fuller
table and the derivation.

## Closed-form generating functions

| Family | \(f(x,y)\) (ordinary) | \(\tilde f(x,y)\) (exponential) |
|---|---|---|
| [Simplex](../catalog/simplex.md) | \(\dfrac{x}{(1-x)(1-x-xy)} - \dfrac{x}{1-xy}\) | \(\dfrac{e^{x(1+y)} - e^x - e^{xy} + 1}{y}\) |
| [Hypercube](../catalog/hypercube.md) | \(\dfrac{1}{1-x(y+2)} - \dfrac{1}{1-xy}\) | \(e^{x(y+2)} - e^{xy}\) |
| [Cross-polytope](../catalog/cross-polytope.md) | \(\dfrac{2x}{(1-x)(1-x-2xy)}\) | \(\dfrac{e^{x(1+2y)}-e^x}{y}\) |
| [Permutohedron](../catalog/permutohedron.md) | *(none — factorial growth)* | \(\dfrac{y}{y+1-e^{xy}}\) |
| [Associahedron](../catalog/associahedron.md) | *(algebraic, not rational — see [Kirkman–Cayley](../catalog/associahedron.md#f-vector))* | — |

Here \(x\) marks the family's size parameter (number of defining points
for the simplex, dimension for the hypercube and cross-polytope, number
of letters for the permutohedron) and \(y^k\) marks a face of dimension
\(k\).

## OEIS cross-reference

| Family | Sequence |
|---|---|
| Simplex | [A007318](https://oeis.org/A007318) (Pascal's triangle) |
| Hypercube | [A038207](https://oeis.org/A038207) |
| Cross-polytope | dual of [A038207](https://oeis.org/A038207) |
| Associahedron | [A033282](https://oeis.org/A033282) (Kirkman–Cayley), totals in [A001003](https://oeis.org/A001003) |
| Permutohedron | [A019538](https://oeis.org/A019538), totals in [A000670](https://oeis.org/A000670) |

## Vertex-count summary

| Family | Dimension | Vertex count |
|---|---|---|
| Simplex \(S_n\) | \(n-1\) | \(n\) |
| Hypercube \(K_n^{(0)}\) | \(n\) | \(2^n\) |
| Cross-polytope \(X_n\) | \(n\) | \(2n\) |
| Associahedron \(K_L\) | \(L-2\) | \(\mathrm{Cat}(L-1)\) |
| Permutohedron \(\Pi_{n-1}\) | \(n-1\) | \(n!\) |
| Hypersimplex \(\Delta(k,n)\) | \(n-1\) | \(\binom{n}{k}\) |
| Cyclic polytope \(C(n,d)\) | \(d\) | \(n\) |

The growth rates alone tell a story: polynomial for the simplex,
exponential for the hypercube and cross-polytope, super-exponential
(Catalan) for the associahedron, and factorial for the permutohedron —
which is exactly why an ordinary generating function stops being the
right tool once you reach it.
