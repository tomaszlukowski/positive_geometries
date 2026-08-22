r"""
Canonical-form machinery shared across the family scripts in
verification/families/.

Convention
----------
For a d-simplex with affine vertices v_0, ..., v_d in R^d, let
b_0(y), ..., b_d(y) be its barycentric coordinate functions: each is the
unique affine-linear function of y = (y_1, ..., y_d) with
b_i(v_j) = delta_ij. b_i vanishes exactly on the facet opposite v_i.

The canonical form of the simplex, in the affine chart with coordinates
y_1, ..., y_d, is the rational d-form

    Omega(Delta) = phi(y) dy_1 ^ ... ^ dy_d,
    phi(y) = d! Vol(Delta) / prod_i b_i(y)
           = |det(v_1 - v_0, ..., v_d - v_0)| / prod_i b_i(y),

matching the bracket formula on docs/catalog/simplex.md (this is exactly
that formula, specialized to an affine chart). d! Vol(Delta) is exactly
the absolute value of that determinant, so no separate volume call is
needed and everything stays in exact rational arithmetic.

For a polytope P dissected into simplices Delta_1, ..., Delta_k by any
triangulation, the canonical-form density is the sum

    phi_P(y) = sum_j phi(Delta_j)(y),

by the triangulation-additivity axiom (docs/theory/canonical-forms.md).
"""


def barycentric_coords(vertices, y_vars):
    d = len(y_vars)
    if len(vertices) != d + 1:
        raise ValueError("need exactly d+1 vertices for a d-simplex")
    M = matrix(QQ, [[1] + list(v) for v in vertices])
    Minv = M.inverse()
    one_y = vector([1] + list(y_vars))
    b = Minv.transpose() * one_y
    return list(b)


def simplex_density(vertices, y_vars):
    d = len(y_vars)
    edges = matrix(QQ, [[vertices[i][k] - vertices[0][k] for k in range(d)]
                         for i in range(1, d + 1)])
    numerator = abs(edges.det())
    b = barycentric_coords(vertices, y_vars)
    denom = prod(b)
    return numerator / denom


def triangulation_density(simplices, all_vertices, y_vars):
    total = SR(0)
    for s in simplices:
        verts = [all_vertices[i] for i in s]
        total += simplex_density(verts, y_vars)
    return total.simplify_full()


def report_equal_up_to_sign(label, expr_a, expr_b):
    """
    Pass/fail for expr_a == +-expr_b after simplification.

    The canonical form of a positive geometry is only defined up to the
    choice of orientation of X_{>=0} (docs/theory/positive-geometries.md):
    flipping that choice flips the overall sign of Omega, so two
    independent derivations are expected to agree only up to a single
    global sign -- that is the correctness criterion checked here, not
    literal equality.
    """
    diff_plus = (expr_a - expr_b).simplify_full()
    diff_minus = (expr_a + expr_b).simplify_full()
    if diff_plus.is_trivial_zero():
        print(f"[PASS] {label}  (matches with the same orientation)")
        return True
    if diff_minus.is_trivial_zero():
        print(f"[PASS] {label}  (matches up to overall orientation sign)")
        return True
    print(f"[FAIL] {label}")
    print(f"       expr_a - expr_b = {diff_plus}")
    return False


def report_equal(label, expr_a, expr_b):
    """Strict equality check (no sign ambiguity) -- e.g. for comparing
    two triangulations computed with the same code/convention."""
    diff = (expr_a - expr_b).simplify_full()
    ok = diff.is_trivial_zero()
    print(f"[{'PASS' if ok else 'FAIL'}] {label}")
    if not ok:
        print(f"       difference: {diff}")
    return ok
