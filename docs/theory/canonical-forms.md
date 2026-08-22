# Canonical forms

## The residue axiom, unpacked

For a \(D\)-dimensional positive geometry \((X, X_{\geq 0})\), the
canonical form \(\Omega(X, X_{\geq 0})\) is the unique top-form on \(X\)
with simple poles exactly on the boundary components \(C_i\) of
\(X_{\geq 0}\), and residue

\[
\Res_{C_i}\, \Omega(X, X_{\geq 0}) = \Omega(C_i, (C_i)_{\geq 0})
\]

along each. Locally, near a smooth point of \(C_i\) cut out by
\(\{\phi_i = 0\}\), this means

\[
\Omega(X, X_{\geq 0}) = \frac{d\phi_i}{\phi_i} \wedge \Omega(C_i,(C_i)_{\geq 0}) + (\text{regular}),
\]

i.e. \(\Omega\) has a logarithmic singularity along every facet, with
"unit residue" fixed by the lower-dimensional form on that facet — which
is why the whole tower is called *canonical*: nothing is chosen, it is
forced all the way down to the \(\pm 1\) at a point.

## Worked example: the interval

Take \(X = \PP^1\) with affine coordinate \(y\), and \(X_{\geq 0} = [0,1]\).
The two boundary points are \(y = 0\) and \(y = 1\), both zero-dimensional
positive geometries with canonical form \(+1\) (fixed by an outward-pointing
orientation convention). The unique rational 1-form on \(\PP^1\) with
simple poles at \(y=0,1\), no poles elsewhere (in particular none at
\(y=\infty\)), and unit residues there is

\[
\Omega([0,1]) = \frac{dy}{y} - \frac{dy}{y-1} = \frac{dy}{y(1-y)}.
\]

This is the \(D=1\) instance of the general polytope pattern: every facet
of a polytope contributes a simple pole with unit residue, and the
canonical form is the sum of these poles arranged so nothing else
singular survives.

## Triangulation and additivity

Canonical forms add under disjoint unions covering the same space: if
\(X_{\geq 0} = Y_1 \cup \dots \cup Y_k\) with the \(Y_j\) overlapping only
on lower-dimensional boundaries, then
\(\Omega(X, X_{\geq 0}) = \sum_j \Omega(X, Y_j)\). Triangulating a polytope
into simplices and summing their (signed) canonical forms is the most
direct way to *compute* \(\Omega\) for a polytope with no closed-form
shortcut — the sum is triangulation-independent, since it is forced to
equal the same unique form regardless of how it is computed. Every
catalog page states the resulting closed form for \(\Omega\) directly;
several (the simplex, the hypercube) have single-term closed forms
because their defining inequalities pair up so cleanly, while others
(the associahedron, the permutohedron) only have compact closed forms in
special low-dimensional cases and are otherwise most easily produced by
triangulation.

## Products

If \((X_1, (X_1)_{\geq 0})\) and \((X_2, (X_2)_{\geq 0})\) are positive
geometries of dimensions \(D_1, D_2\), their product
\((X_1 \times X_2,\, (X_1)_{\geq 0} \times (X_2)_{\geq 0})\) is a positive
geometry of dimension \(D_1 + D_2\), with

\[
\Omega(X_1 \times X_2,\ (X_1)_{\geq 0} \times (X_2)_{\geq 0}) = \Omega(X_1, (X_1)_{\geq 0}) \wedge \Omega(X_2, (X_2)_{\geq 0}).
\]

This is how the hypercube's canonical form (a product of \(n\) copies of
the interval's) factorizes into the simple
\(dy_1 \wedge \cdots \wedge dy_n \big/ \prod_i y_i(y_i - 1)\) form seen on
its [catalog page](../catalog/hypercube.md).

## References

* N. Arkani-Hamed, Y. Bai, T. Lam, *Positive Geometries and Canonical
  Forms*, [arXiv:1703.04541](https://arxiv.org/abs/1703.04541) — Sections 2–3
  cover the residue axiom, triangulation, and products in full generality.
