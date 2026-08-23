# Verification notebooks

Every claim on this site's catalog pages — vertex embeddings, f-vectors,
duals, canonical forms, the volume conjecture, triangulations and
secondary polytopes — is checked independently and computationally, not
just derived by hand. The checks live in
[`sagemath/`](https://github.com/tomaszlukowski/positive_geometries/tree/main/sagemath)
in the site's GitHub repository: one Jupyter notebook per catalog family,
plus the shared SageMath scripts they're built on. This page explains
what's in each notebook and how to run them yourself.

The notebooks are entirely independent of the website itself — nothing
here is required to read the catalog pages — but every family page links
to its own notebook, and the numbers quoted there (a specific volume, a
triangulation count, a term in a canonical form) come directly from
running it.

## What each notebook covers

For every instance of its family (the exact range differs — see
"Coverage", below, and each notebook's own intro cell for the full
explanation), each `*_explorer.ipynb` walks through the same six steps:

1. **Vertices** — the family's own coordinates, matching the "Embeddings
   by dimension" section on that family's catalog page.
2. **Canonical form** — computed via the general nbc-sum method (Brown–Dupont,
   [arXiv:2501.03202](https://arxiv.org/abs/2501.03202), Proposition 6.7),
   checked against the defining pole-structure property (simple poles on
   exactly the facets, nothing else), and — for the non-simple families —
   broken down term by term at every vertex, showing each vertex's
   **valency** (how many facets meet there) and how many terms compete.
3. **Projective dual** — the polar dual taken at the polytope's centroid.
4. **Volume conjecture** — the canonical form, evaluated at the centroid,
   compared against the volume of that same centroid-based dual; the
   simplex notebook's first section also demonstrates directly why it has
   to be the centroid and not an arbitrary interior point.
5. **Triangulations** — every triangulation of the vertex set, and which
   are regular.
6. **Secondary polytope** — its dimension and vertex embedding.

Steps 5–6 are the most expensive computationally and are the first to
become infeasible as an instance grows (see "Coverage" below);
everywhere they're skipped, the notebook says so explicitly rather than
silently stopping.

There's also **`general_canonical_forms.ipynb`**, a family-independent
companion showing the same machinery on a fresh example, a hand-built
custom polytope, and a direct comparison against the simpler formula
that applies only to simple polytopes (Proposition 6.10) — useful as a
tour of the underlying functions rather than a per-family reference.

## Coverage

The general method's cost scales with how many facets meet at a single
vertex, not just the vertex count — so some families reach much further
than others before a notebook cell would take too long to be practical.
Every limit below was actually measured while building these notebooks,
not estimated:

| Family | Notebook | Canonical form / dual / volume conjecture | Triangulations / secondary polytope |
|---|---|---|---|
| [Simplex](catalog/simplex.md) | [`simplex_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/simplex_explorer.ipynb) | \(n=1\)–\(6\) | \(n=1\)–\(6\) (trivial at every \(n\) — a simplex triangulates only as itself) |
| [Hypercube](catalog/hypercube.md) | [`hypercube_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/hypercube_explorer.ipynb) | \(n=1\)–\(6\) | \(n=1\)–\(3\) only (the 4-cube's triangulation count is in the tens of millions) |
| [Cross-polytope](catalog/cross-polytope.md) | [`cross_polytope_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cross_polytope_explorer.ipynb) | \(d=1\)–\(4\) | \(d=1\)–\(4\) (all feasible) |
| [Permutohedron](catalog/permutohedron.md) | [`permutohedron_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/permutohedron_explorer.ipynb) | order \(2\)–\(4\) | order \(2\)–\(3\) only |
| [Associahedron](catalog/associahedron.md) | [`associahedron_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/associahedron_explorer.ipynb) | \(L=3\)–\(6\) | \(L=3\)–\(4\) only |
| [Cyclohedron](catalog/cyclohedron.md) | [`cyclohedron_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cyclohedron_explorer.ipynb) | \(n=2\)–\(5\) | \(n=2\)–\(3\) only |
| [Stellohedron](catalog/stellohedron.md) | [`stellohedron_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/stellohedron_explorer.ipynb) | \(n=1\)–\(4\) | \(n=1\)–\(2\) only |
| [Hypersimplex](catalog/hypersimplex.md) | [`hypersimplex_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/hypersimplex_explorer.ipynb) | \(n=4\)–\(9\) (volume conjecture only for \(n=4\)–\(7\) — it needs a second, costlier computation) | \(n=4\)–\(5\) only |
| [Cyclic polytope](catalog/cyclic-polytope.md) | [`cyclic_polytope_explorer.ipynb`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/cyclic_polytope_explorer.ipynb) | \(d=2\)–\(4\) only | \(d=2\)–\(4\) (all feasible) |

Beyond `*_explorer.ipynb`, the same `sagemath/` folder has one `.sage`
script per family checking f-vectors, volumes, and duals directly (no
Jupyter needed — `run_all.sage` runs all nine in one pass, currently
55/55 passing), plus `general_canonical_forms.sage` and
`vertex_sum_canonical_forms.sage`, the two independently-implemented
canonical-form methods the notebooks are built on.

## Installing SageMath and Jupyter

The notebooks need [SageMath](https://www.sagemath.org/) — a large
piece of software, so the practical route on any platform is
[conda-forge](https://conda-forge.org/) via
[Miniforge](https://github.com/conda-forge/miniforge) or
[mamba](https://mamba.readthedocs.io/), which also bundles JupyterLab
and a `sagemath` Jupyter kernel — nothing else to install separately:

```bash
mamba create -n sage -c conda-forge sage
mamba activate sage
sage --version   # should print "SageMath version 10.x, ..."
```

**On Windows**, SageMath doesn't install natively — the recipe above
needs to run inside [WSL2](https://learn.microsoft.com/windows/wsl/)
(Windows Subsystem for Linux), not a native Windows shell. See
[`sagemath/README.md`](https://github.com/tomaszlukowski/positive_geometries/blob/main/sagemath/README.md#reinstalling-from-scratch-eg-after-a-fresh-windows-install)
for the exact step-by-step recipe this project itself was built and
tested with, including TOPCOM (only needed for the `.sage` check
scripts, not the notebooks) and — worth reading even if you're not on
Windows — two genuine pitfalls hit while building this: a Jupyter
auth-disabling flag that silently breaks VS Code's connection to a
remote kernel, and a WSL-specific crash triggered by one particular
SageMath/TOPCOM code path (with its safe replacement already built into
`common.sage`, so the notebooks themselves never hit it).

## Running the notebooks

```bash
mamba activate sage   # if not already active
git clone https://github.com/tomaszlukowski/positive_geometries.git
cd positive_geometries/sagemath
jupyter lab
```

Open whichever `*_explorer.ipynb` you want from the file browser; if it
doesn't already show "SageMath" as the kernel in the top right, pick it
via **Kernel → Change Kernel → sagemath**. Every notebook's first code
cell `load()`s the shared `.sage` scripts in the same folder, so run
cells top to bottom from the start — each family's notebook is
otherwise fully self-contained.

## References

* F. Brown, C. Dupont, *Positive geometries and canonical forms via
  mixed Hodge theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202) —
  the canonical-form methods (Propositions 6.7 and 6.10) every notebook
  is built on.
* [SageMath](https://www.sagemath.org/) and its
  [`Polyhedron`](https://doc.sagemath.org/html/en/reference/discrete_geometry/sage/geometry/polyhedron/constructor.html)
  and
  [`PointConfiguration`](https://doc.sagemath.org/html/en/reference/discrete_geometry/sage/geometry/triangulation/point_configuration.html)
  classes, which do the heavy lifting throughout.
* [TOPCOM](https://www.wm.uni-bayreuth.de/de/team/rambau_joerg/TOPCOM/index.html),
  used by the `.sage` check scripts (not the notebooks, which avoid it —
  see [Installing SageMath and Jupyter](#installing-sagemath-and-jupyter)
  above) for triangulation enumeration.
