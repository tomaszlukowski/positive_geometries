# SageMath verification scripts

Independent checks of the vertex embeddings, f-vectors, volumes, duals,
and canonical forms published at
[tomaszlukowski.github.io/positive_geometries](https://tomaszlukowski.github.io/positive_geometries/) —
one small script per catalog family, each covering that family's n=1,2,3
instances (or the family-appropriate equivalent — L for the
associahedron, n=d+3 for cyclic polytopes, the k=2 slice for the
hypersimplex — matching the site's own "Embeddings by dimension"
sections). This folder is **not** part of the website (it's outside
`docs/`, so `mkdocs build` never touches it), and it's a fresh,
self-contained rewrite — not the same code as the earlier
[`../verification/`](../verification/) folder, though it checks the
same kinds of claims.

**Every check in this folder has actually been run**, in the WSL2 +
SageMath 10.9 + TOPCOM environment set up on this machine earlier in
this project (unlike `../mathematica/`, which is ready-to-run but
untested since there's no Mathematica installation here). Current
results: `run_all.sage` **42/42**, `vertex_sum_canonical_forms.sage`
**14/14**, `general_canonical_forms.sage` **26/26**.

## Contents

- **`common.sage`** — shared machinery: vertex generators for all seven
  families, the triangulation-additivity canonical-form computation
  (via TOPCOM's placing triangulation, `PointConfiguration`), and three
  check helpers (`check_fvector`, `check_volume`, `check_canonical_form`)
  that print PASS/FAIL and accumulate results for a final summary.
- **`simplex.sage`, `hypercube.sage`, `cross_polytope.sage`,
  `permutohedron.sage`, `associahedron.sage`, `hypersimplex.sage`,
  `cyclic_polytope.sage`** — one script per family. Each is runnable on
  its own (`sage simplex.sage`) — it auto-loads `common.sage` if it
  hasn't been already — and prints its own PASS/FAIL summary.
- **`run_all.sage`** — loads every family script in one session and
  prints one combined summary at the end (this is what produced the
  42/42 result above).
- **`vertex_sum_canonical_forms.sage`** — a second, independent way to
  compute canonical forms, using the closed formula from F. Brown,
  C. Dupont, *Positive geometries and canonical forms via mixed Hodge
  theory*, [arXiv:2501.03202](https://arxiv.org/abs/2501.03202),
  Proposition 6.10: for a **simple** polytope, sum one term per vertex —
  no triangulation, no TOPCOM, just the polytope's own facet
  inequalities. Covers the simplex, hypercube, permutohedron, and
  associahedron (the simple families in this catalog) at d=1,2,3;
  cross-polytope/hypersimplex/cyclic polytope are simplicial rather than
  simple, so this formula doesn't directly apply to them (the script
  says so explicitly rather than giving a silently wrong answer). Every
  result is checked against the *defining* property of a canonical
  form — simple poles on exactly the polytope's own facets, nothing
  else — which is how a real bug in `common.sage` got caught; see below.
- **`general_canonical_forms.sage`** — the fully general version, for
  **any** convex polytope, simple or not, via Proposition 6.7 of the
  same paper: a sum over "non-broken-circuit" (nbc) sets of the facet
  hyperplane arrangement, with a coefficient given by an iterated
  boundary map (nonzero exactly when a set of facets forms a genuine
  flag — facet ⊃ ridge ⊃ ... ⊃ vertex — in the polytope's face lattice).
  Circuits and nbc sets are computed via Sage's own `Matroid` class
  (treating each facet as a vector in the affine functionals' coefficient
  space) rather than hand-rolled combinatorics. Covers the cross-polytope,
  hypersimplex, and cyclic polytope — the non-simple families this
  catalog's Prop. 6.10 script above can't reach — plus the simple
  families too (it reduces to exactly the same answer there, checked
  directly). The script **reproduces the paper's own square-pyramid
  example (Section 6.7) term by term, exactly** — not just up to overall
  sign — which is the strongest evidence of correctness in this whole
  project: 26/26 checks pass, including that exact match, pole-structure
  verification on every non-simple family at every tested dimension, and
  agreement with `vertex_sum_canonical_forms.sage` wherever both apply.

## ⚠ A real bug found in `common.sage`, while building the script above

`canonical_form_density` (the triangulation-based method used by every
other script in this folder) was cross-checked against
`vertex_sum_canonical_forms.sage`'s independent, pole-structure-verified
results, and the two **disagree** for polygons needing more than a
couple of triangles — confirmed on two unrelated hexagons (a generic
one and the reduced-chart permutohedron n=3), regardless of which vertex
the fan triangulation starts from. `canonical_form_density` produces
spurious extra poles along internal triangulation diagonals that should
cancel but don't. This was checked with exact polynomial-ring
arithmetic, not just `.simplify_full()` (which can fail to spot
cancellation on its own — that possibility was specifically ruled out).

The simplex/hypercube canonical-form checks reported elsewhere in this
project as passing are **not** affected — those specific cases (a
single simplex needing no triangulation at all, and the cube's fan
triangulation from one vertex) are confirmed correct — but treat
`canonical_form_density` with caution on anything more combinatorially
complex than what's already been checked, until this is properly
root-caused. The root cause is not yet known: it is not simply the
`abs()` in the numerator discarding a sign (using the signed determinant
directly reproduces the exact same spurious factors). For simple
polytopes, prefer `vertex_sum_canonical_forms.sage` instead. See the
`KNOWN ISSUE` comment at the top of `common.sage` for the full writeup.

## One-time environment setup

These scripts need SageMath, which isn't practical to install natively
on Windows — this project uses **WSL2 + a conda-forge SageMath
environment**. If you're on this machine, this is already installed;
if you're setting up fresh (or on a different machine), here's the
exact recipe that was used (run from an elevated/admin PowerShell where
noted):

```powershell
# 1. WSL2 + Ubuntu, if not already installed
wsl --install -d Ubuntu   # then set a username/password when it launches

# 2. Miniforge (conda + mamba) inside WSL
wsl -d Ubuntu -u root -- bash -c "curl -fsSL -o /tmp/miniforge.sh https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh && bash /tmp/miniforge.sh -b -p /opt/miniforge3"

# 3. A `sage` conda environment (this takes a while -- it's a big package)
wsl -d Ubuntu -u root -- /opt/miniforge3/bin/mamba create -y -n sage -c conda-forge sage

# 4. TOPCOM, for the triangulation-based canonical-form checks (via apt --
#    conda-forge doesn't package it). Its binaries install prefixed
#    (topcom-points2finetriang etc.); Sage expects unprefixed names, so
#    symlink them.
wsl -d Ubuntu -u root -- apt-get update
wsl -d Ubuntu -u root -- apt-get install -y topcom
wsl -d Ubuntu -u root -- bash -c 'mkdir -p /usr/local/bin; for f in /usr/bin/topcom-*; do ln -sf "$f" "/usr/local/bin/$(basename "$f" | sed "s/^topcom-//")"; done'
```

Verify it worked:

```powershell
wsl -d Ubuntu -- /opt/miniforge3/envs/sage/bin/sage --version
```

should print something like `SageMath version 10.9, ...`.

## Running the scripts

**Important**: this repository lives on a Google Drive virtual drive
(`G:\...`). WSL2 cannot mount that drive — `/mnt/g/...` doesn't work for
it, the same way `wsl.exe` itself can't resolve a `G:\` path as a
working directory (a real, general WSL2 limitation with cloud-sync
virtual drives, not something specific to this project). **Local**
Windows drives (`C:\...`) mount into WSL fine at `/mnt/c/...`, so the
practical workflow is: copy this folder to a local path, then run it
from there.

```powershell
# 1. Sync this folder to a local path (re-run this after editing any script)
$dest = "$env:USERPROFILE\pg_sage_sync"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item "G:\My Drive\Claude Code\Positive geometries website\sagemath\*" -Destination $dest -Recurse -Force

# 2. Run everything
wsl -d Ubuntu --cd $dest.Replace('C:\','/mnt/c/').Replace('\','/') -- /opt/miniforge3/envs/sage/bin/sage run_all.sage
```

Or, more simply, once you know the local path doesn't change:

```powershell
wsl -d Ubuntu --cd /mnt/c/Users/<you>/pg_sage_sync -- /opt/miniforge3/envs/sage/bin/sage run_all.sage
```

To run just one family:

```powershell
wsl -d Ubuntu --cd /mnt/c/Users/<you>/pg_sage_sync -- /opt/miniforge3/envs/sage/bin/sage simplex.sage
```

(You can also `wsl -d Ubuntu` to get an interactive shell, `cd
/mnt/c/Users/<you>/pg_sage_sync`, and run `sage run_all.sage` directly —
`sage` is on `PATH` inside WSL once the environment above is activated,
or use the full `/opt/miniforge3/envs/sage/bin/sage` path as above,
which works regardless of shell activation.)

## What "verification" means here

Every expected value each script checks against was worked out
independently beforehand — from the site's published closed-form
combinatorial formulas (Pascal's triangle for the simplex, Kirkman–Cayley
numbers for the associahedron, etc.) or, where no simple formula exists,
computed once by hand via Sage and cross-checked against the same
numbers already published in the site's f-vector tables. Running these
scripts is a **second**, independent pass — different code, same
methodology as `../verification/`, extended to cover all seven families
instead of the original two. A few volumes (permutohedron, associahedron,
hypersimplex) live in a hyperplane of their ambient space, so
`measure='induced'` is used to get the intrinsic Euclidean volume rather
than the (zero) ambient one — `common.sage`'s `check_volume` takes this
as a parameter per call.
