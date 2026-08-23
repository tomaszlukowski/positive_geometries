---
title: Positive Geometries
description: A compendium of positive geometries — definitions, canonical forms, and combinatorics, with a focus on polytopes.
---

<div class="pg-hero" markdown>
<div class="pg-hero__text" markdown>

# Positive Geometries

A compendium of **positive geometries** — spaces that carry a distinguished
"positive part" and a canonical differential form determined entirely by
its boundary structure. This site collects their definitions, catalogs the
polytopal examples, and works out their combinatorics: f-vectors,
generating functions, and canonical forms.

[Start with the definition](theory/positive-geometries.md){ .md-button }
[Browse the catalog](catalog/simplex.md){ .md-button .md-button--secondary }

</div>
<div class="pg-hero__viewer" markdown>
<div class="polytope-viewer" data-shape="associahedron">
<span class="polytope-viewer__label">Associahedron</span>
<span class="polytope-viewer__hint">drag · scroll</span>
</div>
</div>
</div>

## What is a positive geometry?

A positive geometry is a pair \((X, X_{\geq 0})\) of a complex projective
variety \(X\) and an oriented "positive" region \(X_{\geq 0}\) inside its
real points, singled out by the existence of a unique rational top-form
\(\Omega(X, X_{\geq 0})\) — the **canonical form** — whose residues on
every boundary reproduce the canonical form of that boundary, recursively
down to a point. Convex polytopes are the founding example: the positive
region is the polytope itself, and the canonical form has logarithmic
singularities exactly on its facets. See
[Positive geometries](theory/positive-geometries.md) for the precise
definition, and [Canonical forms](theory/canonical-forms.md) for how the
residue axiom pins the form down uniquely.

The notion was introduced to explain why scattering amplitudes in certain
gauge and gravity theories are computed by the volume of an underlying
geometric object; see [Physics motivation](theory/physics-motivation.md).

## Explore

<div class="pg-cards" markdown>
<a class="pg-card" href="theory/positive-geometries/">
<span class="pg-card__title">Theory</span>
<span class="pg-card__desc">Definitions, the residue axiom, canonical forms, f-vectors, and the physics motivation.</span>
</a>
<a class="pg-card" href="catalog/simplex/">
<span class="pg-card__title">Catalog</span>
<span class="pg-card__desc">Simplex, hypercube, cross-polytope, associahedron, permutohedron, hypersimplex, cyclic polytope, generalized permutohedra.</span>
</a>
<a class="pg-card" href="data/f-vector-tables/">
<span class="pg-card__title">Data</span>
<span class="pg-card__desc">f-vector tables, generating functions, and OEIS cross-references for every family in the catalog.</span>
</a>
<a class="pg-card" href="notebooks/">
<span class="pg-card__title">Notebooks</span>
<span class="pg-card__desc">Jupyter notebooks that verify every catalog claim computationally, and how to run them yourself.</span>
</a>
<a class="pg-card" href="references/">
<span class="pg-card__title">References</span>
<span class="pg-card__desc">The literature this site draws on.</span>
</a>
</div>

## About this site

This is a rebuild of a 2021 first attempt at the same idea. See the
[about page](about.md) for more, and the
[GitHub repository](https://github.com/tomaszlukowski/positive_geometries)
to suggest a correction or addition — the catalog is meant to keep growing.
