# Hypersimplex

## Definition

The **hypersimplex** \(\Delta(k,n)\), for \(1 \leq k \leq n-1\), is the
convex hull of all 0/1 vectors in \(\RR^n\) with exactly \(k\) ones:
\[
\Delta(k,n) = \conv\lbrace  e_S : S \subset \lbrace 1,\dots,n\rbrace ,\ |S| = k \rbrace ,
\qquad e_S = \sum_{i \in S} e_i.
\]
Equivalently, it is the slice \(\lbrace x \in [0,1]^n : \sum_i x_i = k\rbrace \) of
the [hypercube](hypercube.md). It is the **matroid polytope** of the
uniform matroid \(U_{k,n}\), and a member of the
[generalized permutohedron](generalized-permutohedra.md) family.

## Properties

* Dimension \(n-1\); \(\binom{n}{k}\) vertices.
* \(2n\) facets for \(1 < k < n-1\) — the same \(x_i \geq 0\) and
  \(x_i \leq 1\) inequalities that cut out the hypercube slice, all of
  which remain facet-defining in this range.
* \(\Delta(1,n)\) is the standard \((n-1)\)-[simplex](simplex.md), and by
  the symmetry \(\Delta(k,n) \cong \Delta(n-k,n)\) so is \(\Delta(n-1,n)\).
* \(\Delta(2,4)\) is combinatorially the **octahedron** — the
  3-dimensional [cross-polytope](cross-polytope.md) — a coincidence
  worth pointing out precisely because a general hypersimplex is *not* a
  cross-polytope; it stops coinciding with any family already in this
  catalog beyond this one case.
* Central to the positive Grassmannian: the positive part of the
  Grassmannian \(\mathrm{Gr}(k,n)\) projects onto \(\Delta(k,n)\), and the
  images of its positroid cells give a well-studied polyhedral
  subdivision of it.

## Interactive model

Since \(\Delta(2,4)\) coincides with the octahedron, it reuses that
viewer:

<div class="polytope-viewer" data-shape="cross-polytope">
<span class="polytope-viewer__label">&Delta;(2,4)</span>
<span class="polytope-viewer__hint">drag to rotate · scroll to zoom</span>
</div>

## References

* A. Postnikov, *Permutohedra, Associahedra, and Beyond*,
  [arXiv:math/0507163](https://arxiv.org/abs/math/0507163).
* A. Postnikov, D. Speyer, L. Williams, *Matching Polytopes,
  Toric Geometry, and the Non-negative Part of the Grassmannian*,
  [arXiv:0706.2501](https://arxiv.org/abs/0706.2501).
