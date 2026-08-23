r"""
common.sage -- shared machinery for every script and notebook in this
directory: vertex generators, the canonical-form method, duals,
triangulations/secondary polytopes, and pass/fail check helpers.

Vertex generators
------------------
All generators use exact rational arithmetic (QQ) and match the
coordinates on the site's "Embeddings by dimension" sections exactly
(same formulas as docs/assets/js/polytope-data.js).

Canonical forms
----------------
general_canonical_form_density (below) computes the canonical form of
ANY full-dimensional convex polytope -- simple or not -- via

    F. Brown, C. Dupont, "Positive geometries and canonical forms via
    mixed Hodge theory", arXiv:2501.03202, Proposition 6.7.

as a sum over "non-broken-circuit" (nbc) sets of the facet hyperplane
arrangement, with a coefficient given by an iterated boundary map
(nonzero exactly when a set of facets forms a genuine flag -- facet D
ridge D ... D vertex -- in the polytope's face lattice). This is the
single validated method every script and *_explorer.ipynb notebook in
this folder builds on. See general_canonical_forms.sage for the full
derivation, worked examples (including an exact term-by-term
reproduction of the paper's own square-pyramid example), and the
self-test suite. vertex_sum_canonical_forms.sage implements a second,
independent formula (Proposition 6.10) that only covers SIMPLE
polytopes, kept separately as a cross-check.

An earlier triangulation-additivity approach (sum simplex canonical
forms over a TOPCOM triangulation) lived in this file and was used by
a couple of the family scripts; it was found, by cross-checking against
the vertex-sum formula, to produce spurious extra poles for polygons
needing more than ~2-3 triangles, root cause never pinned down. It has
been removed outright (not just documented around) now that the general
nbc-sum method above covers every family in this collection, simple or
not, with no such issue -- see git history if the old implementation is
ever needed for reference.
"""

import itertools

# ---------------------------------------------------------------------
# Vertex generators
# ---------------------------------------------------------------------

def simplex_vertices(d):
    """d+1 vertices of the standard d-simplex, reduced chart: identity
    rows plus the origin."""
    I = identity_matrix(QQ, d)
    return [tuple(I[i]) for i in range(d)] + [tuple([0] * d)]

def hypercube_vertices(d):
    """2^d vertices of [0,1]^d."""
    return list(itertools.product([0, 1], repeat=d))

def cross_polytope_vertices(d):
    """2d vertices +-e_i of the d-dimensional cross-polytope."""
    verts = []
    for i in range(d):
        v1 = [0] * d; v1[i] = 1; verts.append(tuple(v1))
        v2 = [0] * d; v2[i] = -1; verts.append(tuple(v2))
    return verts

def permutohedron_vertices(n):
    """n! vertices of the order-n permutohedron: every permutation of
    (1,...,n), dimension n-1."""
    return [tuple(p) for p in Permutations(range(1, n + 1))]

def _binary_trees(n):
    if n == 1:
        return [None]
    trees = []
    for i in range(1, n):
        for l in _binary_trees(i):
            for r in _binary_trees(n - i):
                trees.append((l, r))
    return trees

def _count_leaves(t):
    return 1 if t is None else _count_leaves(t[0]) + _count_leaves(t[1])

def _loday_coords(tree, num_leaves):
    coords = [0] * (num_leaves - 1)
    idx = [0]
    def visit(t):
        if t is None:
            return
        visit(t[0])
        coords[idx[0]] = _count_leaves(t[0]) * _count_leaves(t[1])
        idx[0] += 1
        visit(t[1])
    visit(tree)
    return tuple(coords)

def associahedron_vertices(L):
    """Catalan(L-1) vertices of the L-leaf associahedron, Loday's
    coordinates in R^(L-1), dimension L-2."""
    return [_loday_coords(t, L) for t in _binary_trees(L)]

def hypersimplex_vertices(k, n):
    """binomial(n,k) vertices of Delta(k,n): every 0/1 vector in R^n
    with exactly k ones, dimension n-1."""
    return [tuple(1 if i in S else 0 for i in range(n))
            for S in itertools.combinations(range(n), k)]

def cyclic_polytope_vertices(n, d):
    """n vertices of the cyclic polytope C(n,d) on the moment curve,
    integer parameters t=1,...,n."""
    return [tuple(t ** p for p in range(1, d + 1)) for t in range(1, n + 1)]

def reduce_codim1(pts):
    """If pts affinely span a hyperplane of R^N (dimension N-1, e.g. the
    permutohedron's and associahedron's natural embeddings, which live in
    a sum=const hyperplane), drop the last ambient coordinate to get an
    equivalent full-dimensional point set in R^{N-1}. Valid whenever the
    hyperplane's defining equation has a nonzero coefficient on the
    dropped coordinate -- true for every family in this collection."""
    N = len(pts[0])
    return [tuple(p[:N - 1]) for p in pts]

# ---------------------------------------------------------------------
# Canonical forms -- Brown-Dupont Proposition 6.7 (general nbc-sum
# method; see the module docstring and general_canonical_forms.sage
# for the full derivation)
# ---------------------------------------------------------------------

def facet_data(P, order=None):
    """List of (b_i, a_i, Hrepresentation_object) for each facet of P, in
    a fixed order (Sage's own order by default, or 'order': an explicit
    list of Hrepresentation objects, e.g. to match a paper's labeling)."""
    hreps = order if order is not None else list(P.Hrepresentation())
    return [(h.b(), vector(QQ, h.A()), h) for h in hreps]

def vertex_local_indices(v, fdata):
    """Positions (into fdata) of the facets containing vertex v."""
    incident = set(v.incident())
    return [i for i, (b, a, h) in enumerate(fdata) if h in incident]

def local_matroid(fdata, S_v):
    """Linear matroid on the homogeneous vectors (b_i,a_i), i in S_v."""
    cols = [vector(QQ, [fdata[i][0]] + list(fdata[i][1])) for i in S_v]
    return Matroid(matrix=matrix(QQ, cols).transpose())

def nbc_bases(fdata, S_v):
    """n-element subsets of S_v (as sorted tuples of GLOBAL indices) that
    are bases of the local matroid and contain no broken circuit."""
    mat = local_matroid(fdata, S_v)
    local_to_global = dict(enumerate(S_v))
    broken = [frozenset(sorted((local_to_global[i] for i in c),
                                key=lambda g: g)[1:])
              for c in mat.circuits()]
    result = []
    for B in mat.bases():
        B_global = frozenset(local_to_global[i] for i in B)
        if not any(bc <= B_global for bc in broken):
            result.append(tuple(sorted(B_global)))
    return result

def flag_sign(P, I_sorted, fdata):
    """I_sorted: increasing tuple of n global facet indices. Processes
    them largest-to-smallest, requiring each step to drop the dimension
    by exactly 1 (a genuine facet of the previous piece). Returns
    sign(det(A_I)) if the flag survives all the way to a point, else 0."""
    Q = P
    for idx in reversed(I_sorted):
        b, a, h = fdata[idx]
        newQ = Q.intersection(Polyhedron(eqns=[[b] + list(a)]))
        if newQ.dimension() != Q.dimension() - 1:
            return 0
        Q = newQ
    if Q.dimension() != 0:
        return 0
    A = matrix(QQ, [fdata[i][1] for i in I_sorted])
    d = A.det()
    return 1 if d > 0 else (-1 if d < 0 else 0)

def _nbc_terms_at_vertex(P, v, fdata, y_vars):
    """Every surviving nbc-basis term at vertex v: a list of
    (I, det_abs, f_list) -- I the tuple of GLOBAL facet indices (into
    fdata) for one nbc basis at v whose flag doesn't vanish, det_abs the
    bracket |det(A_I)|, f_list the n facet linear functions in I -- plus
    the vertex's valency (number of facets through it, i.e. len(S_v);
    exactly n for a simple vertex, more for a non-simple one, and it's
    this count, not graph-theoretic edge degree, that controls how many
    nbc candidates exist at v). Shared by general_canonical_form_density
    (which just sums everything) and canonical_form_by_vertex (which
    keeps every vertex's contribution separate, for display)."""
    n = P.dimension()
    S_v = vertex_local_indices(v, fdata)
    out = []
    for I in nbc_bases(fdata, S_v):
        if flag_sign(P, I, fdata) == 0:
            continue
        A = matrix(QQ, [fdata[i][1] for i in I])
        det_abs = abs(A.det())
        f_list = [fdata[i][0] + sum(QQ(fdata[i][1][j]) * y_vars[j] for j in range(n))
                  for i in I]
        out.append((I, det_abs, f_list))
    return out, len(S_v)

def general_canonical_form_density(P, y_vars, order=None):
    """Proposition 6.7: canonical-form density of ANY full-dimensional
    convex polytope P (simple or not), as a sum over nbc sets with
    nonzero iterated-boundary coefficient.

    The result is returned with its denominator FACTORED (via .factor(),
    not just .simplify_full()) -- e.g. 1/((y1-1)*y1*(y2-1)*y2) rather
    than a single expanded polynomial denominator. This is purely a
    presentation choice (a canonical form's whole point is that its
    denominator is a product of the linear facet functions, so a
    factored display matches that structure); it doesn't change the
    value, and downstream code that pulls the denominator back apart
    (verify_pole_structure, .numerator_denominator() generally) works
    the same either way.

    For a non-simple polytope this single expression can be genuinely
    hard to read -- see canonical_form_by_vertex below for the same
    computation broken down term by term, per vertex, instead."""
    n = P.dimension()
    if len(y_vars) != n:
        raise ValueError(f"P has dimension {n} but {len(y_vars)} y-variables were given")
    fdata = facet_data(P, order=order)
    total = SR(0)
    for v in P.vertex_generator():
        terms, _ = _nbc_terms_at_vertex(P, v, fdata, y_vars)
        for I, det_abs, f_list in terms:
            total += det_abs / prod(f_list)
    sign_const = (-1) ** (n * (n + 1) // 2)
    return (sign_const * total).simplify_full().factor()

def canonical_form_by_vertex(P, y_vars, order=None):
    """The same computation as general_canonical_form_density, broken
    down vertex by vertex instead of summed into one expression --
    illuminating for a non-simple polytope, where a single vertex can
    contribute more than one nbc term (a simple vertex -- valency == n,
    the polytope's dimension -- always contributes exactly one).

    Returns a list of dicts, one per vertex of P:
        {'vertex': v,          # the Polyhedron vertex object (coordinates)
         'facets': S_v,        # combinatorial label: GLOBAL indices (into
                                # facet_data(P, order)) of the facets
                                # through v -- this, not the coordinates,
                                # is what actually determines the nbc
                                # combinatorics at v
         'valency': len(S_v),
         'is_simple': len(S_v) == P.dimension(),
         'terms': [(I, term), ...]}   # I: sorted tuple of global facet
                                       # indices for one surviving nbc
                                       # basis at v (I subset S_v);
                                       # term: that single basis's own
                                       # signed, factored contribution
                                       # (same global sign convention as
                                       # general_canonical_form_density)
    Summing every 'term' over every vertex reproduces
    general_canonical_form_density(P, y_vars, order) exactly."""
    n = P.dimension()
    if len(y_vars) != n:
        raise ValueError(f"P has dimension {n} but {len(y_vars)} y-variables were given")
    fdata = facet_data(P, order=order)
    sign_const = (-1) ** (n * (n + 1) // 2)
    rows = []
    for v in P.vertex_generator():
        S_v = vertex_local_indices(v, fdata)
        terms, valency = _nbc_terms_at_vertex(P, v, fdata, y_vars)
        row_terms = [(I, (sign_const * det_abs / prod(f_list)).factor())
                     for I, det_abs, f_list in terms]
        rows.append({'vertex': v, 'facets': tuple(S_v), 'valency': valency,
                     'is_simple': valency == n, 'terms': row_terms})
    return rows

def print_canonical_form_by_vertex(rows):
    """Pretty-prints canonical_form_by_vertex's output: one block per
    vertex, its coordinates, which facets (by global index) meet there
    and how many (the valency), whether that makes it simple, and each
    surviving nbc term's own facet subset and factored contribution."""
    for i, row in enumerate(rows):
        v = row['vertex']
        tag = "simple" if row['is_simple'] else f"NOT simple -- {len(row['terms'])} nbc term(s) survive"
        print(f"vertex {i}: {tuple(v)}")
        print(f"    facets through it: {row['facets']}  (valency {row['valency']}, {tag})")
        for I, term in row['terms']:
            print(f"    -> nbc basis {I}: {term}")

def verify_pole_structure(label, phi, P, y_vars):
    """The defining property of a canonical form: simple poles exactly
    on P's own facets, nothing else."""
    R = PolynomialRing(QQ, [str(v) for v in y_vars])
    _, den = phi.numerator_denominator()
    factors = list(R(den).factor())
    ok = (len(factors) == P.n_facets()) and all(m == 1 for _, m in factors)
    print(f"[{'PASS' if ok else 'FAIL'}] {label}: {len(factors)} pole factors "
          f"(expected {P.n_facets()} facets), all simple: {all(m == 1 for _, m in factors)}")
    return ok

# ---------------------------------------------------------------------
# Duals and triangulation/secondary-polytope exploration
# (used by the per-family *_explorer.ipynb notebooks)
# ---------------------------------------------------------------------

def polar_dual(P):
    """The polar (projective) dual of P.

    Sage's own Polyhedron.polar() requires the origin to be in P's
    relative interior, which usually isn't already true of these
    families' vertex lists (e.g. the simplex, whose vertices are the
    standard basis vectors plus the origin -- a vertex, not an interior
    point). Translate by the centroid first so this works unconditionally,
    in exact rational arithmetic throughout."""
    pts = P.vertices_list()
    d = len(pts[0])
    n = len(pts)
    c = [sum(QQ(p[i]) for p in pts) / n for i in range(d)]
    centered = [tuple(QQ(p[i]) - c[i] for i in range(d)) for p in pts]
    return Polyhedron(vertices=centered).polar()

def reduce_secondary_polytope(sp):
    """The secondary polytope, re-expressed in its own affine hull.

    pc.secondary_polytope() (see secondary_polytope_data) naturally
    lives in R^N, N = number of points in the configuration -- one
    coordinate per point, its GKZ vector's own ambient space -- even
    though its actual dimension is only N - d - 1 (d = dimension of the
    point configuration): every GKZ vector satisfies d+1 fixed linear
    relations (they all have the same "moment" against the point
    configuration's own affine coordinates and the all-ones vector), so
    N - d - 1 of the N ambient directions are entirely redundant. This
    calls Sage's own Polyhedron.affine_hull_projection() to drop exactly
    that redundancy: same polytope (same combinatorics, same dimension,
    which .dimension() already reports correctly even on the un-reduced
    sp), but with vertex coordinates given in R^(N-d-1) instead of R^N --
    e.g. the cube's secondary polytope is 4-dimensional either way, but
    its vertices are 8-tuples before this and 4-tuples after. Exact
    (stays over ZZ/QQ, confirmed -- no field extension needed here,
    unlike the orthogonal=True variant of this method)."""
    return sp.affine_hull_projection()

def secondary_polytope_data(pts):
    """Every triangulation of pts, together with the secondary polytope
    and which triangulations are regular.

    NOTE ON METHOD: Sage/TOPCOM can test regularity directly via
    PointConfiguration.restrict_to_regular_triangulations(), but that
    calls out to the external topcom-points2triangs process through
    pexpect -- which, on this machine's WSL2 setup, was found to hang
    and crash the WSL service outright (confirmed reproducibly while
    building this function; recovering needs `wsl --shutdown` from
    Windows -- see README.md). This function avoids that path entirely:
    it enumerates ALL triangulations with Sage's own INTERNAL engine (no
    subprocess, no TOPCOM, confirmed reliable), computes each one's GKZ
    vector via Triangulation.gkz_phi(), and separately computes the
    secondary polytope (also internal-engine, also reliable). A
    triangulation is regular exactly when its GKZ vector is a vertex of
    the secondary polytope -- that IS the defining correspondence
    between regular triangulations and the secondary polytope's vertices
    (GKZ 1994, Ch. 7) -- so matching the two gives regularity without
    ever invoking TOPCOM's separate --regular flag. Checked against a
    square (2 triangulations, both regular, matching the well-known fact
    that every triangulation of a convex quadrilateral is regular)
    before use. The regularity matching itself is done against the raw
    (un-reduced) sp -- its vertices are exactly the GKZ vectors computed
    here, directly comparable; see reduce_secondary_polytope for a
    version with the ambient redundancy stripped out, for display.

    Returns (secondary_polytope, secondary_polytope_reduced, rows) where
    rows is a list of (triangulation, gkz_vector, is_regular)."""
    pc = PointConfiguration(pts)
    sp = pc.secondary_polytope()
    sp_verts = set(tuple(v) for v in sp.vertices_list())
    rows = []
    for t in pc.triangulations():
        phi = tuple(t.gkz_phi())
        rows.append((t, phi, phi in sp_verts))
    return sp, reduce_secondary_polytope(sp), rows

# ---------------------------------------------------------------------
# Check helpers
# ---------------------------------------------------------------------

_all_results = []

def check_fvector(label, pts, expected_f):
    P = Polyhedron(vertices=pts)
    f = tuple(P.f_vector()[1:-1])  # drop the leading/trailing 1's (empty face, polytope itself)
    ok = (f == tuple(expected_f))
    status = "PASS" if ok else "FAIL"
    print(f"[{status}] {label}  vertices={len(pts)}  f-vector={f}  expected={tuple(expected_f)}")
    _all_results.append((f"{label} f-vector", ok))
    return P, f

def check_volume(label, pts, expected_vol, measure='ambient'):
    P = Polyhedron(vertices=pts)
    vol = P.volume(measure=measure)
    if expected_vol is None:
        print(f"[INFO] {label}  volume={vol}  (no asserted expected value)")
        return vol
    ok = bool((vol - expected_vol) == 0)
    status = "PASS" if ok else "FAIL"
    print(f"[{status}] {label}  volume={vol}  expected={expected_vol}")
    _all_results.append((f"{label} volume", ok))
    return vol

def check_canonical_form(label, pts, known_density, y_vars):
    """Compute the canonical form via the general nbc-sum method
    (Proposition 6.7) and check it two ways: against the defining
    pole-structure property, and against a known closed form up to the
    overall orientation sign built into the definition."""
    P = Polyhedron(vertices=pts)
    phi = general_canonical_form_density(P, y_vars)
    pole_ok = verify_pole_structure(f"{label} (pole structure)", phi, P, y_vars)
    _all_results.append((f"{label} canonical form (pole structure)", pole_ok))
    diff_plus = (phi - known_density).simplify_full()
    diff_minus = (phi + known_density).simplify_full()
    ok = diff_plus.is_trivial_zero() or diff_minus.is_trivial_zero()
    status = "PASS" if ok else "FAIL"
    note = "(same orientation)" if diff_plus.is_trivial_zero() else \
           "(up to overall orientation sign)" if diff_minus.is_trivial_zero() else ""
    print(f"[{status}] {label} canonical form {note}")
    print(f"       computed: {phi}")
    _all_results.append((f"{label} canonical form (matches known formula)", ok))
    return phi

def print_summary():
    print()
    print(f"=== SUMMARY: {len(_all_results)} checks ===")
    n_pass = sum(1 for _, ok in _all_results if ok)
    for label, ok in _all_results:
        print(f"  [{'PASS' if ok else 'FAIL'}] {label}")
    print(f"{n_pass}/{len(_all_results)} passed.")
    if n_pass < len(_all_results):
        print("SOME CHECKS FAILED -- see FAIL lines above.")
    return n_pass == len(_all_results)
