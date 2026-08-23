# Cross-polytope

## Definition

The **\(n\)-dimensional cross-polytope** (or *orthoplex*, or generalized
octahedron) is the convex hull of the \(n\) coordinate axis pairs,

\[
X_n = \conv\lbrace \pm e_1, \dots, \pm e_n\rbrace  \subset \RR^n,
\]

equivalently the unit ball of the \(\ell_1\) norm,
\(X_n = \lbrace x \in \RR^n : |x_1| + \cdots + |x_n| \leq 1\rbrace \), a polytope of
dimension \(n\). It is the **polar dual** of the [hypercube](hypercube.md):
facets of one correspond to vertices of the other.

## Properties

* Dimension \(n\); \(2n\) vertices, \(2^n\) facets (each facet a copy of
  the \((n-1)\)-simplex, one for each sign pattern \((\pm 1)^n\)).
* A proper face of dimension \(k\) is spanned by choosing \(k+1\) of the
  \(n\) coordinate axes and one of the two vertices \(\pm e_i\) on each —
  this is what makes every proper face of \(X_n\) a simplex.
* Simplicial polytope (dual to the hypercube's simple polytope), and the
  boundary complex of \(X_n\) triangulates the \((n-1)\)-sphere in the
  most economical possible way for its vertex count.

## f-vector

\[
f_k(X_n) = \binom{n}{k+1}\, 2^{k+1},
\]

choosing which \(k+1\) axes span the face, then a sign for each. (This
triangle is the polar-dual counterpart of the hypercube's
[A038207](https://oeis.org/A038207); each row is 2 times a row of
Pascal's triangle shifted and rescaled by a power of 2.)

| \(n\) | \(f_0\) | \(f_1\) | \(f_2\) | \(f_3\) | \(f_4\) | \(f_5\) |
|---|---|---|---|---|---|---|
| 1 | 2 | — | — | — | — | — |
| 2 | 4 | 4 | — | — | — | — |
| 3 | 6 | 12 | 8 | — | — | — |
| 4 | 8 | 24 | 32 | 16 | — | — |
| 5 | 10 | 40 | 80 | 80 | 32 | — |
| 6 | 12 | 60 | 160 | 240 | 192 | 64 |

## Generating functions

\[
f(x,y) = \sum_{n \geq 1} x^n \sum_{k=0}^{n-1} \binom{n}{k+1} 2^{k+1} y^k
= \frac{2x}{(1-x)(1 - x - 2xy)},
\]

\[
\tilde f(x,y) = \sum_{n \geq 1} \frac{x^n}{n!} \sum_{k=0}^{n-1} \binom{n}{k+1} 2^{k+1} y^k
= \frac{e^{x(1+2y)} - e^{x}}{y}.
\]

## Canonical form

Unlike the hypercube, \(X_n\) is not a product of lower-dimensional
positive geometries, so its canonical form has no single-formula
shortcut. It follows directly from
[triangulation-additivity](../theory/canonical-forms.md#triangulation-and-additivity):
coning the boundary from the origin splits \(X_n\) into \(2^n\) simplices,
one per sign pattern \(s \in \lbrace \pm1\rbrace ^n\), each spanned by the origin and
\(\lbrace s_i e_i\rbrace _{i=1}^n\), and

\[
\Omega(X_n) = \sum_{s \in \lbrace \pm 1\rbrace ^n} \Omega\big(\conv\lbrace 0, s_1 e_1, \dots, s_n e_n\rbrace \big),
\]

with each summand the simplex canonical form from the
[simplex page](simplex.md).

This coning triangulation gives \(2^n\) terms — one per sign pattern.
It's not the only way to decompose \(\Omega(X_n)\): Brown–Dupont's
general vertex-by-vertex formula (F. Brown, C. Dupont, *Positive
geometries and canonical forms via mixed Hodge theory*,
[arXiv:2501.03202](https://arxiv.org/abs/2501.03202), Proposition 6.7 —
needed here rather than the simpler Proposition 6.10, since \(X_n\) is
*not* simple: each vertex lies on \(2^{n-1}\) facets, not just \(n\))
gives a *different* decomposition, summing several competing terms at
each of the \(2n\) vertices instead of one term at each of the \(2^n\)
cone points, yet reproduces the exact same \(\Omega(X_n)\) — an
independent check of the formula above, computed and verified in
[sagemath/cross_polytope_explorer.ipynb](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cross_polytope_explorer.ipynb),
which also breaks the sum down term by term at every vertex.

**Volume conjecture.** The canonical form, evaluated at the centroid (in
a chart re-centered there), equals \(\pm\, n!\) times the volume of
\(X_n\)'s own projective dual taken at that same centroid — for \(n=3\),
\(3!\cdot\mathrm{Vol}(\text{dual}) = 6\cdot 8 = 48\), matching the
centroid value exactly (see the note on [simplex.md](simplex.md#canonical-form)
for why the reference point has to be the centroid specifically).

## Embeddings by dimension

Vertices of \(X_d\) — \(\pm e_i\) for each of the \(d\) coordinate axes:

=== "d = 1"
    \((1)\), \((-1)\)

=== "d = 2"
    \((1,0)\), \((-1,0)\), \((0,1)\), \((0,-1)\)

=== "d = 3"
    the octahedron: \((1,0,0)\), \((-1,0,0)\), \((0,1,0)\),
    \((0,-1,0)\), \((0,0,1)\), \((0,0,-1)\)

=== "d = 4"
    \((1,0,0,0)\), \((-1,0,0,0)\), \((0,1,0,0)\), \((0,-1,0,0)\),
    \((0,0,1,0)\), \((0,0,-1,0)\), \((0,0,0,1)\), \((0,0,0,-1)\)

=== "d = 5"
    \((1,0,0,0,0)\), \((-1,0,0,0,0)\), \((0,1,0,0,0)\), \((0,-1,0,0,0)\),
    \((0,0,1,0,0)\), \((0,0,-1,0,0)\), \((0,0,0,1,0)\), \((0,0,0,-1,0)\),
    \((0,0,0,0,1)\), \((0,0,0,0,-1)\)

=== "d = 6"
    \((1,0,0,0,0,0)\), \((-1,0,0,0,0,0)\), \((0,1,0,0,0,0)\),
    \((0,-1,0,0,0,0)\), \((0,0,1,0,0,0)\), \((0,0,-1,0,0,0)\),
    \((0,0,0,1,0,0)\), \((0,0,0,-1,0,0)\), \((0,0,0,0,1,0)\),
    \((0,0,0,0,-1,0)\), \((0,0,0,0,0,1)\), \((0,0,0,0,0,-1)\)

## Dual and triangulations (verified for d = 3)

For the octahedron \(X_3\), computed in SageMath — see
[`sagemath/`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/README.md)
for the current verification scripts and notebooks:

- **Dual**: \((\pm2,0,0)\), \((0,\pm2,0)\), \((0,0,\pm2)\) — f-vector
  \((1,8,12,6,1)\), combinatorially the [hypercube](hypercube.md),
  confirming the duality claimed above.
- **Triangulations & secondary polytope**: **3** triangulations in
  total, all regular — secondary polytope of dimension 2 with 3
  vertices. Each corresponds to picking one of the octahedron's 3 long
  diagonals (a pair of opposite vertices \(e_i, -e_i\)) and fanning the
  other 4 vertices into 4 tetrahedra around it — confirmed directly from
  each triangulation's GKZ vector, not assumed.

## Verification notebook

Every claim on this page is checked computationally in
[`sagemath/cross_polytope_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cross_polytope_explorer.ipynb) —
vertices, canonical form, dual, the volume conjecture, triangulations,
and the secondary polytope, for \(d=1\) through \(4\). See
[Verification notebooks](../notebooks.md) for what's in it and how to
run it yourself.

## References

* N. Arkani-Hamed, Y. Bai, T. Lam, *Positive Geometries and Canonical
  Forms*, [arXiv:1703.04541](https://arxiv.org/abs/1703.04541), §3.
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.7, the general vertex-by-vertex method cross-checked
  against the coning formula above.
* [OEIS A038207](https://oeis.org/A038207) — the dual hypercube triangle.
