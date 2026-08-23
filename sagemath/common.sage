r"""
common.sage -- shared machinery for the per-family verification scripts
in this directory.

Vertex generators
------------------
All generators use exact rational arithmetic (QQ) and match the
coordinates on the site's "Embeddings by dimension" sections exactly
(same formulas as docs/assets/js/polytope-data.js, mathematica/
PositiveGeometries.wl, and the earlier verification/families/*.sage
scripts -- three independently written implementations, now four).

Canonical forms
----------------
For a d-simplex with affine vertices v_0,...,v_d in R^d, the canonical
form density (coefficient of dy_1^...^dy_d, in the affine chart with
coordinates y_1,...,y_d) is

    phi(y) = d! Vol(simplex) / prod_i b_i(y)
           = |det(v_1-v_0,...,v_d-v_0)| / prod_i b_i(y),

where b_i(y) is the barycentric coordinate function of vertex v_i (the
affine-linear function with b_i(v_j) = delta_ij, vanishing exactly on
the facet opposite v_i) -- matching the bracket formula on
docs/catalog/simplex.md. For a general polytope, phi is the sum of this
over any triangulation into simplices (triangulation-additivity,
docs/theory/canonical-forms.md); TOPCOM's placing triangulation is used
here via PointConfiguration, same as the earlier verification/ scripts.
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

# ---------------------------------------------------------------------
# Canonical forms (triangulation-additivity)
# ---------------------------------------------------------------------

def barycentric_coords(vertices, y_vars):
    d = len(y_vars)
    if len(vertices) != d + 1:
        raise ValueError("need exactly d+1 vertices for a d-simplex")
    M = matrix(QQ, [[1] + list(v) for v in vertices])
    Minv = M.inverse()
    one_y = vector([1] + list(y_vars))
    return list(Minv.transpose() * one_y)

def simplex_density(vertices, y_vars):
    d = len(y_vars)
    edges = matrix(QQ, [[vertices[i][k] - vertices[0][k] for k in range(d)]
                         for i in range(1, d + 1)])
    numerator = abs(edges.det())
    denom = prod(barycentric_coords(vertices, y_vars))
    return numerator / denom

def triangulation_density(simplices, all_vertices, y_vars):
    total = SR(0)
    for s in simplices:
        verts = [all_vertices[i] for i in s]
        total += simplex_density(verts, y_vars)
    return total.simplify_full()

def canonical_form_density(pts, y_vars):
    """Triangulate pts (via TOPCOM's placing triangulation) and sum the
    simplex canonical-form density over every piece."""
    pc = PointConfiguration(pts)
    simplices = list(pc.triangulate())
    return triangulation_density(simplices, pts, y_vars)

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
    phi = canonical_form_density(pts, y_vars)
    diff_plus = (phi - known_density).simplify_full()
    diff_minus = (phi + known_density).simplify_full()
    ok = diff_plus.is_trivial_zero() or diff_minus.is_trivial_zero()
    status = "PASS" if ok else "FAIL"
    note = "(same orientation)" if diff_plus.is_trivial_zero() else \
           "(up to overall orientation sign)" if diff_minus.is_trivial_zero() else ""
    print(f"[{status}] {label} canonical form {note}")
    print(f"       computed: {phi}")
    _all_results.append((f"{label} canonical form", ok))
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
