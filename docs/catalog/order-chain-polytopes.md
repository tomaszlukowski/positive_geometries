# Order and chain polytopes

## Definition

For a finite poset \(P\) on \(n\) elements \(p_1,\dots,p_n\), R. Stanley
associates to it two \((0,1)\)-polytopes in \(\RR^n\)
(*Two poset polytopes*, Discrete Comput. Geom. 1 (1986) 9–23):

The **order polytope**

\[
O(P) = \lbrace x \in \RR^n : 0 \leq x_i \leq 1,\ \ x_i \leq x_j
\text{ whenever } p_i \leq_P p_j \rbrace,
\]

whose vertices are exactly the indicator vectors of the **order filters**
(up-sets) of \(P\); and the **chain polytope**

\[
C(P) = \Big\lbrace x \in \RR^n : x_i \geq 0,\ \ \sum_{p_i \in \gamma} x_i
\leq 1 \text{ for every chain } \gamma \text{ of } P \Big\rbrace,
\]

whose vertices are exactly the indicator vectors of the **antichains** of
\(P\). Both have dimension \(n\), and both have the same number of
vertices — one per antichain of \(P\) either way, since an order filter is
determined by (and determines) the antichain of its own minimal elements.
This site computes both directly from Sage's own `Poset.order_polytope()`/
`.chain_polytope()` rather than re-deriving the up-set/antichain
convention by hand — see [Canonical form](#canonical-form) below for how
that was cross-checked before being trusted.

## Properties

* **Stanley's volume theorem**: \(\mathrm{vol}\big(O(P)\big) =
  \mathrm{vol}\big(C(P)\big) = e(P)/n!\), where \(e(P)\) is the number of
  **linear extensions** of \(P\) — checked directly against
  `poset.linear_extensions()`, an independent combinatorial count that
  doesn't touch the polytopes at all, for every example poset below.
* \(O(P)\) and \(C(P)\) are **Ehrhart-equivalent** (same volume, and in
  fact the same Ehrhart polynomial) but **not combinatorially equivalent
  in general** — their f-vectors can differ beyond \(f_0\). This is easy
  to miss from small examples (two of the four posets below happen to
  give matching f-vectors, or even the literal same polytope), so this
  page deliberately includes a poset where they genuinely diverge.
* The (open) **Hibi–Li conjecture** proposes that \(C(P)\)'s f-vector
  always dominates \(O(P)\)'s, entry by entry — consistent with, though of
  course not proof of, every example checked on this page.
* An **antichain** (no relations at all) makes every subset simultaneously
  an order filter and an antichain, so \(O(P) = C(P)\) literally, the
  \(n\)-cube. A **chain** (a total order) makes \(O(P)\) and \(C(P)\)
  different-looking but combinatorially identical \(n\)-simplices —
  see [Example posets](#example-posets) below for both.

## Example posets

Four posets, chosen to span the range above, matching
[`sagemath/order_chain_polytopes.sage`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/order_chain_polytopes.sage):

| Poset | \(n\) | \(e(P)\) | \(\mathrm{vol}=e(P)/n!\) | \(f\)-vector of \(O(P)\) | \(f\)-vector of \(C(P)\) |
|---|---|---|---|---|---|
| Antichain on 3 elements | 3 | 6 | 1 | \((8,12,6)\) | \((8,12,6)\) — literally the same polytope |
| Chain on 4 elements | 4 | 1 | \(1/24\) | \((5,10,10,5)\) | \((5,10,10,5)\) — same type, different embedding |
| "N" poset (\(a<c\), \(b<c\), \(b<d\)) | 4 | 5 | \(5/24\) | \((8,18,17,7)\) | \((8,18,17,7)\) — coincidentally equal |
| Rank-\((2,2,2)\) "double diamond" | 6 | 8 | \(1/90\) | \((10,39,77,82,46,12)\) | \((10,39,78,86,51,14)\) — **genuinely differ** |

The "double diamond" — two elements below two elements below two elements,
complete bipartite between consecutive ranks — was found by an exhaustive
search over `Posets(6)` while building this page specifically because its
\(O(P)\) and \(C(P)\) diverge; it is the general case, not a contrived
exception. Its two f-vectors also satisfy the Hibi–Li dominance check
above: \((39,78,86,51,14) \geq (39,77,82,46,12)\) entrywise.

## Canonical form

Neither \(O(P)\) nor \(C(P)\) is simple in general (the "N" and "double
diamond" posets above both give non-simple polytopes), so the
[simplex's](simplex.md) and [permutohedron's](permutohedron.md#canonical-form)
one-term-per-vertex shortcut (Proposition 6.10) doesn't apply uniformly
here; the fully general formula does (F. Brown, C. Dupont, *Positive
geometries and canonical forms via mixed Hodge theory*,
[arXiv:2501.03202](https://arxiv.org/abs/2501.03202), Proposition 6.7): at
each vertex, sum over every non-broken-circuit subset of the facets
through it whose associated flag survives an iterated boundary map.
Checked directly against the defining pole-structure property in
[sagemath/order_chain_polytopes.sage](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/order_chain_polytopes.sage)
for both \(O(P)\) and \(C(P)\), all four posets above; see
[order_chain_polytopes_explorer.ipynb](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/order_chain_polytopes_explorer.ipynb)
for the term-by-term breakdown at every vertex.

**Volume conjecture.** The canonical form, evaluated at the centroid (in a
chart re-centered there), equals \(\pm\, d!\) times the volume of the
polytope's own projective dual taken at that same centroid — verified
numerically in the notebook above for every poset and both polytopes (see
[simplex.md](simplex.md#canonical-form) for why the reference point has to
be the centroid specifically).

## Triangulations and secondary polytopes

Unlike most other families in this catalog, **nothing is skipped here** —
every triangulation-enumeration step, for both \(O(P)\) and \(C(P)\), for
all four posets including the 6-element, dimension-6 "double diamond",
finished in well under a minute while building this page (the double
diamond's own pair, its most expensive, took under half a second each).
Full triangulation counts, regularity, and secondary-polytope embeddings
for every case are in the notebook.

## Verification notebook

Every claim on this page is checked computationally in
[`sagemath/order_chain_polytopes_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/order_chain_polytopes_explorer.ipynb) —
vertices, canonical form, dual, volume conjecture, triangulations, and
secondary polytope, for both \(O(P)\) and \(C(P)\), for all four posets
above. See [Verification notebooks](../notebooks.md) for what's in it and
how to run it yourself.

## References

* R. Stanley, *Two poset polytopes*, Discrete & Computational Geometry 1
  (1986) 9–23.
* T. Hibi, N. Li, *Unimodular equivalence of order and chain polytopes*,
  Math. Scand. 118 (2016) — the Hibi–Li f-vector dominance conjecture.
* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  Proposition 6.7, the general nbc-sum method behind the canonical form
  above.
* [SageMath `Poset`](https://doc.sagemath.org/html/en/reference/combinat/sage/combinat/posets/posets.html) —
  `order_polytope()` and `chain_polytope()`, used directly rather than
  re-implemented.
