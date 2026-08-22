# Generalized permutohedra

## Definition

A **generalized permutohedron** is any polytope obtained by moving the
facets of the [permutohedron](permutohedron.md) \(\Pi_{n-1}\) parallel to
themselves (some possibly all the way in, collapsing), without changing
their outward normal directions. Equivalently — Postnikov's formulation —
it is any polytope whose edges are all parallel to some \(e_i - e_j\), or
the polytope
\[
P_z = \Big\lbrace  x \in \RR^n : \sum_i x_i = z(\lbrace 1,\dots,n\rbrace ),\ \sum_{i \in S} x_i \leq z(S)\ \ \forall S \subsetneq \lbrace 1,\dots,n\rbrace  \Big\rbrace 
\]
associated to any **submodular function** \(z\) on subsets of
\(\lbrace 1,\dots,n\rbrace \).

## Why this page exists

Three families elsewhere in this catalog are special cases of a single
construction, and it is worth seeing them side by side:

| Family | Submodular function \(z(S)\) |
|---|---|
| [Permutohedron](permutohedron.md) \(\Pi_{n-1}\) | \(z(S) = \binom{\lvert S\rvert + 1}{2}\) |
| [Hypersimplex](hypersimplex.md) \(\Delta(k,n)\) | \(z(S) = \min(\lvert S \rvert, k)\) |
| [Simplex](simplex.md) \(S_n^{(0)}\) | \(z(S) = 1\) if \(S \neq \varnothing\), else \(0\) |

More generally, every **matroid polytope** (the convex hull of the
indicator vectors of a matroid's bases) is a generalized permutohedron
with \(z\) the matroid's rank function, and the
[associahedron](associahedron.md), in Loday's realization, is one too —
its defining submodular function assigns \(z(S) = \binom{\lvert S \rvert + 1}{2}\)
to every subset \(S\) of *consecutive* labels only, which is precisely
what forces its face lattice down from the permutohedron's to the
associahedron's.

Generalized permutohedra are themselves positive geometries (each is
just a convex polytope, so the [definition](../theory/positive-geometries.md)
applies directly), and their canonical forms are computed exactly as any
other polytope's — see
[Canonical forms](../theory/canonical-forms.md#triangulation-and-additivity).
What makes the family worth naming is combinatorial: their face lattices,
f-vectors, and volumes are all governed uniformly by the submodular
function \(z\), giving one theory that specializes to every entry in this
catalog's table.

## References

* A. Postnikov, *Permutohedra, Associahedra, and Beyond*,
  [arXiv:math/0507163](https://arxiv.org/abs/math/0507163).
* A. Postnikov, V. Reiner, L. Williams, *Faces of Generalized
  Permutohedra*, [arXiv:math/0609184](https://arxiv.org/abs/math/0609184).
