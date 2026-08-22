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

## Interactive model

<div class="polytope-viewer" data-shape="cross-polytope">
<span class="polytope-viewer__label">3-dimensional cross-polytope (octahedron)</span>
<span class="polytope-viewer__hint">drag to rotate · scroll to zoom</span>
</div>

## References

* N. Arkani-Hamed, Y. Bai, T. Lam, *Positive Geometries and Canonical
  Forms*, [arXiv:1703.04541](https://arxiv.org/abs/1703.04541), §3.
* [OEIS A038207](https://oeis.org/A038207) — the dual hypercube triangle.
