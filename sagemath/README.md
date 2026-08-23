# SageMath verification scripts

Independent checks of the vertex embeddings, f-vectors, volumes, duals,
canonical forms, triangulations, and secondary polytopes published at
[tomaszlukowski.github.io/positive_geometries](https://tomaszlukowski.github.io/positive_geometries/).
This folder is **not** part of the website (it's outside `docs/`, so
`mkdocs build` never touches it).

**Every check in this folder has actually been run**, in the WSL2 +
SageMath 10.9 + TOPCOM environment set up on this machine. Current
results: `run_all.sage` **55/55**, `vertex_sum_canonical_forms.sage`
**14/14**, `general_canonical_forms.sage` **26/26**, and all nine
`*_explorer.ipynb` notebooks executed headlessly end-to-end with zero
errors (see the table under **Contents** below for exactly how far each
one goes, and why).

Two earlier verification efforts (a Mathematica package, and a smaller
two-family `verification/` folder using an older, buggier method) have
been removed; see git history if either is ever needed for reference.

## Contents

- **`common.sage`** — the shared foundation everything else in this
  folder builds on:
  - vertex generators for all nine catalog families, including
    `graph_associahedron_vertices` (Devadoss's construction from any
    connected graph, arXiv:math/0612530) and its `cyclohedron_vertices`
    / `stellohedron_vertices` specializations;
  - `reduce_codim1`, for families whose natural embedding lives in a
    hyperplane of a higher ambient space (permutohedron, associahedron,
    hypersimplex);
  - **`general_canonical_form_density`** — the canonical-form method
    used everywhere in this folder: Brown–Dupont's Proposition 6.7 (a
    sum over non-broken-circuit sets of the facet arrangement, via
    Sage's `Matroid` class), valid for **any** full-dimensional convex
    polytope, simple or not. Returned with its denominator **factored**
    (`.factor()`, not just `.simplify_full()`) — e.g.
    `1/((y1-1)*y1*(y2-1)*y2)` rather than one expanded polynomial — since
    a canonical form's whole point is that its poles are a product of
    the facets' own linear functions, so a factored display matches
    that structure; `vertex_canonical_form_density` in
    `vertex_sum_canonical_forms.sage` does the same. See
    `general_canonical_forms.sage` for the full derivation and
    worked-example reproduction;
  - **`canonical_form_by_vertex`** / **`print_canonical_form_by_vertex`**
    — the same computation, broken down vertex by vertex instead of
    summed into one expression. For a non-simple polytope, one combined
    expression can be genuinely hard to read (a degree-4 numerator over
    8 denominator factors, for the octahedron); this shows, per vertex,
    its **valency** (how many facets meet there — exactly the dimension
    for a simple vertex, more otherwise, and it's this count, not
    graph-theoretic edge degree, that controls how many nbc terms
    compete) and each surviving nbc term's own small, factored
    contribution. Summing every term reproduces
    `general_canonical_form_density`'s answer exactly (checked directly
    wherever this is used). Used in every `*_explorer.ipynb` notebook's
    "Canonical form, broken down by vertex" section, right after the
    whole-polytope expression: most illuminating on the non-simple
    families (`cross_polytope_explorer.ipynb`,
    `hypersimplex_explorer.ipynb`, `cyclic_polytope_explorer.ipynb`),
    where a vertex can have several surviving nbc terms; on the simple
    families (simplex, hypercube, permutohedron, associahedron) it
    collapses to exactly one term per vertex, still worth showing as a
    direct, visible confirmation that the general method reduces to
    Proposition 6.10's one-term-per-vertex formula there;
  - `verify_pole_structure` — the model-independent correctness check
    used throughout: a canonical form is *defined* by having simple
    poles exactly on the polytope's own facets and nowhere else, so
    this is checked directly rather than only comparing against an
    already-known answer;
  - `polar_dual` — the projective (polar) dual, after centering at the
    centroid (`Polyhedron.polar()` needs the origin in the interior,
    which these families' own vertex lists don't already satisfy);
  - `secondary_polytope_data` — every triangulation of a point set, the
    secondary polytope, and which triangulations are regular (see
    **Jupyter / TOPCOM crashes WSL**, below, for why this deliberately
    avoids TOPCOM's own regularity test);
  - `reduce_secondary_polytope` — the secondary polytope re-expressed in
    its own affine hull (via `Polyhedron.affine_hull_projection()`):
    `pc.secondary_polytope()` naturally lives in R^(number of points) —
    one coordinate per point — even though its actual dimension is
    usually much smaller (e.g. the cube's secondary polytope is
    4-dimensional but its raw vertices are 8-tuples); this drops the
    redundant ambient coordinates so vertices are genuine
    `dimension()`-tuples. `secondary_polytope_data` returns this
    already computed, as its second return value;
  - three check helpers (`check_fvector`, `check_volume`,
    `check_canonical_form`) that print PASS/FAIL and accumulate results
    for a final summary.
- **`simplex.sage`, `hypercube.sage`, `cross_polytope.sage`,
  `permutohedron.sage`, `associahedron.sage`, `hypersimplex.sage`,
  `cyclic_polytope.sage`, `cyclohedron.sage`, `stellohedron.sage`** —
  one script per family, each covering that family's n=1,2,3 instances
  (or the
  family-appropriate equivalent — L for the associahedron, n=d+3 for
  cyclic polytopes, the k=2 slice for the hypersimplex). Each is
  runnable on its own (`sage simplex.sage`) — it auto-loads
  `common.sage` if it hasn't been already.
- **`run_all.sage`** — loads every family script in one session and
  prints one combined summary at the end.
- **`general_canonical_forms.sage`** — the derivation, worked-example
  reproduction, and self-test suite for the general method (defined in
  `common.sage`, not here — this file is documentation plus tests, not
  a second implementation). Reproduces the paper's own square-pyramid
  example (Section 6.7) **term by term, exactly** — not just up to
  overall sign — the strongest evidence of correctness in this folder.
  Also checks every non-simple family (cross-polytope, hypersimplex,
  cyclic polytope) via pole structure, and cross-checks agreement with
  `vertex_sum_canonical_forms.sage` on the simple families.
- **`vertex_sum_canonical_forms.sage`** — a second, independently
  implemented method, for cross-checking only: Proposition 6.10, valid
  for **simple** polytopes (simplex, hypercube, permutohedron,
  associahedron in this catalog) — one term per vertex, no matroid
  combinatorics, no flag bookkeeping. Used by
  `general_canonical_forms.sage` to confirm the two methods agree
  exactly on the families where both apply.
- **`*_explorer.ipynb`** — one Jupyter notebook per catalog family (all
  nine now built), each walking through: vertices, canonical form (with
  pole-structure check), projective dual, the **volume conjecture**
  (canonical form vs. the volume of the projective dual, taken at the
  centroid — see `simplex_explorer.ipynb`'s n=1 section for why it has
  to be the centroid and not an arbitrary interior point), all
  triangulations with regularity, and the secondary polytope's vertex
  embedding. See **Running interactively**, below.

  **Not every family reaches n=6, and not every instance gets every
  section** — each notebook only goes as far as was actually measured
  to run in reasonable time, documented in that notebook's own intro
  cell rather than silently truncated:

  | Family | Canonical form / dual / volume conjecture | Triangulations / secondary polytope |
  |---|---|---|
  | simplex | n = 1–6 | n = 1–6 (trivial at every n — a simplex is its own only triangulation) |
  | hypercube | n = 1–6 | n = 1–3 only (n=4's triangulation count is in the tens of millions) |
  | cross-polytope | d = 1–4 (d=5 exceeded 90s) | d = 1–4 (all fine) |
  | permutohedron | order = 2–4 / d = 1–3 (order 5 exceeded 90s) | order = 2–3 only (order 4 exceeded 45s) |
  | associahedron | L = 3–6 / d = 1–4 (L=7 exceeded 45s) | L = 3–4 only (L=5 exceeded 45s) |
  | cyclohedron | n = 2–5 / d = 1–4 (n=6 exceeded 60s) | n = 2–3 only (n=4 exceeded 90s) |
  | stellohedron | n = 1–4 (n=5 exceeded 60s) | n = 1–2 only (n=3 exceeded 90s) |
  | hypersimplex | n = 4–9 / d = 3–8 (n=8,9 skip the volume conjecture specifically — see below) | n = 4–5 only (n=6 exceeded 45s) |
  | cyclic polytope | d = 2–4 only (d=5 exceeded 60s) | d = 2–4 (all fine) |

  Two genuinely different bottlenecks show up here, not one: triangulation
  enumeration (via `secondary_polytope_data`'s internal-engine
  enumeration — safe, but still combinatorially explosive for some
  families) hits its ceiling first and separately from canonical-form
  computation itself (via `general_canonical_form_density`, whose cost
  scales with how many facets meet at each vertex — brutal for the
  cross-polytope and cyclic polytope specifically, gentler elsewhere).
  A third, narrower one shows up only in `hypersimplex_explorer.ipynb`:
  the volume conjecture needs a *second* canonical-form computation in
  re-centered coordinates, measured there to be substantially more
  expensive than the original chart, so it's dropped (canonical form and
  dual are kept) for n=8, 9 specifically even though plain canonical-form
  computation is cheap at those sizes.
- **`general_canonical_forms.ipynb`** — a general-purpose companion
  notebook (not tied to one family) demonstrating the API directly:
  a fresh family instance, a hand-built custom polytope, a Prop. 6.7 vs
  6.10 cross-check, and vertex-by-vertex nbc/flag inspection.

## Reinstalling from scratch (e.g. after a fresh Windows install)

This project uses **WSL2 + a conda-forge SageMath environment**, since
SageMath isn't practical to install natively on Windows. If this
machine already has the environment set up, skip to
**Running the scripts**. Otherwise, here's the exact recipe, in order,
with a way to check each step actually worked before moving to the
next one:

```powershell
# 1. WSL2 + Ubuntu (run from an elevated/admin PowerShell)
wsl --install -d Ubuntu
# Reboot if prompted, then launch Ubuntu from the Start menu once to
# finish setup and set a UNIX username/password.

# 2. Check it's there:
wsl -l -v
# Should list "Ubuntu", state "Running" (or "Stopped" -- either is fine
# at this point), version 2.

# 3. Miniforge (conda + mamba) inside WSL
wsl -d Ubuntu -u root -- bash -c "curl -fsSL -o /tmp/miniforge.sh https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh && bash /tmp/miniforge.sh -b -p /opt/miniforge3"

# 4. A `sage` conda environment (this takes a while -- it's a big package)
wsl -d Ubuntu -u root -- /opt/miniforge3/bin/mamba create -y -n sage -c conda-forge sage

# 5. Check it worked:
wsl -d Ubuntu -- /opt/miniforge3/envs/sage/bin/sage --version
# Should print "SageMath version 10.9, ..." (or similar).

# 6. TOPCOM, for triangulation enumeration (via apt -- conda-forge
#    doesn't package it). Its binaries install prefixed
#    (topcom-points2finetriang etc.); Sage expects unprefixed names, so
#    symlink them.
wsl -d Ubuntu -u root -- apt-get update
wsl -d Ubuntu -u root -- apt-get install -y topcom
wsl -d Ubuntu -u root -- bash -c 'mkdir -p /usr/local/bin; for f in /usr/bin/topcom-*; do ln -sf "$f" "/usr/local/bin/$(basename "$f" | sed "s/^topcom-//")"; done'

# 7. Check it worked:
wsl -d Ubuntu -- bash -c "echo '{{0,1,2}}' | points2placingtriang"
# Should print a triangulation like "{{0,1,2}}", not "command not found".
```

If you're driving `wsl.exe` from Git-Bash / the Claude Code Bash tool
rather than plain PowerShell, set `export MSYS_NO_PATHCONV=1` first —
otherwise MSYS rewrites `-d`-style flags and Unix-looking paths in ways
that break `wsl.exe`'s own argument parsing. You'll also see a harmless
line on every invocation, `wsl: Failed to translate 'G:\...'` — that's
WSL trying and failing to resolve the *current working directory* (see
next section for why), not an error in the command itself; ignore it.

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
wsl -d Ubuntu --cd /mnt/c/Users/tomas/pg_sage_sync -- /opt/miniforge3/envs/sage/bin/sage run_all.sage
```

To run just one family, or one of the two canonical-form scripts:

```powershell
wsl -d Ubuntu --cd /mnt/c/Users/tomas/pg_sage_sync -- /opt/miniforge3/envs/sage/bin/sage simplex.sage
wsl -d Ubuntu --cd /mnt/c/Users/tomas/pg_sage_sync -- /opt/miniforge3/envs/sage/bin/sage general_canonical_forms.sage
```

(You can also `wsl -d Ubuntu` to get an interactive shell, `cd
/mnt/c/Users/tomas/pg_sage_sync`, and run `sage run_all.sage` directly —
`sage` is on `PATH` inside WSL once the environment above is activated,
or use the full `/opt/miniforge3/envs/sage/bin/sage` path as above,
which works regardless of shell activation.)

## Running interactively: Jupyter notebook

The conda-forge `sage` environment already bundles JupyterLab and a
registered `sagemath` kernel — nothing extra to install. Sync this
folder locally first (step 1 above), then launch the server:

```powershell
wsl -d Ubuntu -- /opt/miniforge3/envs/sage/bin/jupyter lab --no-browser --ip=127.0.0.1 --port=8888 --notebook-dir=/mnt/c/Users/tomas/pg_sage_sync
```

Leave that running (it's a server, not a one-shot command — run it in
its own terminal, or with `run_in_background`-style tooling). Jupyter
prints a URL with a token on startup, e.g.:

```
http://127.0.0.1:8888/lab?token=<a long hex string>
```

Copy that **whole URL, including `?token=...`**, and either paste it
into a normal Windows browser, or use it as the "Existing Jupyter
Server" URL if you're connecting from VS Code's built-in Jupyter
support (Command Palette → "Jupyter: Specify Jupyter Server for
Connections" → paste the URL). WSL2 forwards `localhost` ports to
Windows automatically, no extra setup needed. Open the notebook you
want from there; if it doesn't already show "SageMath 10.9" in the top
right, pick it via Kernel → Change Kernel → sagemath. `load(...)` calls
inside a notebook resolve relative to wherever you launched Jupyter
from (matching `--notebook-dir` above), so keep every notebook in the
same synced folder as the `.sage` files.

### Pitfall: disabling Jupyter's auth breaks VS Code silently

**Don't add `--ServerApp.token='' --ServerApp.password=''`** to disable
auth, even though `--ip=127.0.0.1` means the server only ever accepts
local connections anyway. That combination disables Jupyter's `/login`
route *entirely* (not just the token check) — and VS Code's Jupyter
extension probes `/login` as part of its connection handshake. The
failure mode is nasty: VS Code shows the server as "connected", cells
run with no error, and simply **never produce any output** — no kernel
ever actually attaches, and nothing in the UI says why. (Confirmed by
checking the server's own log: `404 GET /login`, right when a "no
output" report came in.) Plain token auth — the default, no extra flags
— works correctly with both a plain browser and VS Code. If you restart
the server, it generates a new random token each time; re-read its
startup output (or the terminal running it) for the new URL.

### Pitfall: TOPCOM's own regularity test crashes the WSL *service*

`PointConfiguration.restrict_to_regular_triangulations()` +
`.triangulations_list()` — Sage's own documented way to ask TOPCOM
which triangulations are regular — was found, while building
`secondary_polytope_data` in `common.sage`, to reliably **hang and then
crash the WSL service itself** on this machine, not just the Sage
process. Recovery needs a full WSL restart from Windows:

```powershell
wsl --shutdown
# wait a couple of seconds, then any `wsl -d Ubuntu -- ...` command
# will start a fresh instance automatically.
```

This will also kill any Jupyter server you had running — relaunch it
and get the new token as above. `secondary_polytope_data` in
`common.sage` avoids this failure mode entirely (Sage's *internal*
triangulation engine, no TOPCOM subprocess, confirmed reliable) — use
it instead of calling TOPCOM's regularity test directly. If you ever do
need TOPCOM's own triangulation enumeration for something this folder
doesn't already cover, there's a second, unrelated footgun worth
knowing about: `PointConfiguration.set_engine('topcom')` gets silently
reset back to the internal engine the *first* time any
`PointConfiguration` is constructed in a session (a one-time internal
`_have_TOPCOM()` probe does this as a side effect) — call
`PointConfiguration._have_TOPCOM()` once yourself, *then*
`set_engine('topcom')`, *then* construct your `PointConfiguration`, or
the engine switch won't stick.

## What "verification" means here

Every expected value each script checks against was worked out
independently beforehand — from the site's published closed-form
combinatorial formulas (Pascal's triangle for the simplex, Kirkman–Cayley
numbers for the associahedron, etc.) or, where no simple formula exists,
computed once by hand via Sage and cross-checked against the same
numbers already published in the site's f-vector tables. Running these
scripts is a **second**, independent pass. A few volumes (permutohedron,
associahedron, hypersimplex) live in a hyperplane of their ambient
space, so `measure='induced'` is used to get the intrinsic Euclidean
volume rather than the (zero) ambient one — `common.sage`'s
`check_volume` takes this as a parameter per call.

Canonical forms are checked two independent ways, not just against a
known formula: (1) the *defining* property — simple poles exactly on
the polytope's own facets, nothing else (`verify_pole_structure`),
which doesn't require already knowing the answer; and (2), where the
site states a closed form, an exact symbolic match up to the overall
orientation sign built into the definition. `general_canonical_forms.sage`
additionally reproduces one of the source paper's own worked examples
(the square pyramid, Section 6.7) term by term, matching its exact
stated formula rather than only agreeing up to sign.
