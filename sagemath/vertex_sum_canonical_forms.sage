r"""
vertex_sum_canonical_forms.sage

Computes the canonical form of any SIMPLE convex polytope in this
collection as a sum over its vertices, using the closed formula given in

    F. Brown, C. Dupont, "Positive geometries and canonical forms via
    mixed Hodge theory", arXiv:2501.03202, Section 6.6, Proposition 6.10.

This is a genuinely different method from the general nbc-sum approach
in common.sage (general_canonical_form_density, Proposition 6.7): no
matroid combinatorics, no flag/boundary-map bookkeeping -- just the
polytope's own facet inequalities, one small determinant per vertex,
valid only for SIMPLE polytopes. Kept here as an independent cross-check
of the general method (see general_canonical_forms.sage, which loads
this file and compares the two on the simplex and hypercube). Run
standalone with 'sage vertex_sum_canonical_forms.sage'.

-----------------------------------------------------------------------
The formula (Proposition 6.10)
-----------------------------------------------------------------------
Let P be a full-dimensional SIMPLE polytope in R^n (every vertex lies on
exactly n facets -- true for the simplex, hypercube, permutohedron, and
associahedron in this catalog, but NOT the cross-polytope, hypersimplex,
or cyclic polytope, which are simplicial rather than simple; see the
note at the bottom). For a vertex v, let F_1,...,F_n be the n facets
through v, each cut out by an affine function f_i (f_i >= 0 on P, f_i =
0 exactly on F_i), and set omega_i = dlog(f_i). Brown-Dupont define, for
a POSITIVELY ORIENTED choice of the order F_1,...,F_n (matching the
tangent cone at v to the positive orthant),

    omega_{P,v} := (-1)^(n(n+1)/2)  omega_1 ^ ... ^ omega_n,

and prove (Prop. 6.10) that

    omega_P = sum_v omega_{P,v}.

-----------------------------------------------------------------------
Reduction to a plain formula (derived here, checked against the paper's
own worked examples -- see the tests below)
-----------------------------------------------------------------------
Writing f_i(y) = b_i + a_i . y, the wedge of n such dlog-forms is a pure
algebra fact: wedging n linear 1-forms whose coefficient vectors are the
rows of a matrix A gives det(A) times the volume form, so

    omega_1 ^ ... ^ omega_n = det(A) / (f_1(y) ... f_n(y)) * dy_1^...^dy_n,

where A is the n x n matrix of the a_i. Re-ordering the n facets to match
the "positively oriented" convention only ever changes the sign of
det(A) to match (it can't change f_i, since dlog kills the positive
rescaling between any affine function vanishing on F_i and the specific
one the paper picks) -- so using det(A) in ANY fixed order and taking
|det(A)| absorbs the ordering choice entirely:

    phi(y) := coefficient of dy_1^...^dy_n in omega_P
            = (-1)^(n(n+1)/2)  sum_v  |det(A_v)| / prod_i f_i(y),

with A_v the matrix of facet-normal coefficient vectors at v, in any
order. This is what vertex_canonical_form_density computes below --
no orientation bookkeeping needed beyond the single global sign
(-1)^(n(n+1)/2), and no triangulation at all.

-----------------------------------------------------------------------
Verification method: pole structure
-----------------------------------------------------------------------
A canonical form is *defined* by having simple poles exactly on the
polytope's own facets and nowhere else (docs/theory/positive-geometries.md).
So besides comparing against known closed forms (done for the simplex
and hypercube, which have one on the site), every result below is
checked against this defining property directly: factor the computed
density's denominator and confirm it has exactly n_facets(P) irreducible
linear factors, each to the first power. This is a strong, general-purpose
check that doesn't depend on already knowing the answer.
"""

try:
    check_fvector
except NameError:
    load("common.sage")


def vertex_canonical_form_density(P, y_vars):
    r"""Proposition 6.10: canonical-form density of a full-dimensional
    SIMPLE polytope P, as a sum over vertices. Raises ValueError if P is
    not simple (some vertex lies on more than n facets)."""
    n = P.dimension()
    if len(y_vars) != n:
        raise ValueError(f"P has dimension {n} but {len(y_vars)} y-variables were given")
    total = SR(0)
    for v in P.vertex_generator():
        incident = list(v.incident())
        if len(incident) != n:
            raise ValueError(
                f"vertex {v} lies on {len(incident)} facets, not {n} -- P is not simple; "
                f"Proposition 6.10 requires a simple polytope (see the non-simple families "
                f"note at the bottom of this file)"
            )
        A = matrix(QQ, [list(h.A()) for h in incident])
        det_abs = abs(A.det())
        f_list = [h.b() + sum(QQ(h.A()[j]) * y_vars[j] for j in range(n)) for h in incident]
        total += det_abs / prod(f_list)
    sign = (-1) ** (n * (n + 1) // 2)
    # Factored denominator for display -- see the same note on
    # general_canonical_form_density in common.sage.
    return (sign * total).simplify_full().factor()


if __name__ == "__main__" or True:
    print("=== Simplex ===")
    for d in [1, 2, 3]:
        y = [var(f"y{i}") for i in range(1, d + 1)]
        P = Polyhedron(vertices=simplex_vertices(d))
        phi = vertex_canonical_form_density(P, y)
        verify_pole_structure(f"Simplex d={d}", phi, P, y)
    # d=3 also matches the site's closed form 1/(y1 y2 y3 y4) up to sign
    y_check3 = [var("y1"), var("y2"), var("y3")]
    phi_simplex3 = vertex_canonical_form_density(Polyhedron(vertices=simplex_vertices(3)), y_check3)
    known_simplex3 = 1 / (y_check3[0] * y_check3[1] * y_check3[2] * (1 - y_check3[0] - y_check3[1] - y_check3[2]))
    diff = (phi_simplex3 - known_simplex3).simplify_full()
    diff_m = (phi_simplex3 + known_simplex3).simplify_full()
    print(f"[{'PASS' if (diff == 0 or diff_m == 0) else 'FAIL'}] Simplex d=3 matches "
          f"docs/catalog/simplex.md closed form, up to overall sign")

    print()
    print("=== Hypercube ===")
    for d in [1, 2, 3]:
        y = [var(f"y{i}") for i in range(1, d + 1)]
        P = Polyhedron(vertices=hypercube_vertices(d))
        phi = vertex_canonical_form_density(P, y)
        verify_pole_structure(f"Hypercube d={d}", phi, P, y)
    phi_cube3 = vertex_canonical_form_density(Polyhedron(vertices=hypercube_vertices(3)), y_check3)
    known_cube3 = 1 / prod(y_check3[i] * (y_check3[i] - 1) for i in range(3))
    diff = (phi_cube3 - known_cube3).simplify_full()
    diff_m = (phi_cube3 + known_cube3).simplify_full()
    print(f"[{'PASS' if (diff == 0 or diff_m == 0) else 'FAIL'}] Hypercube d=3 matches "
          f"docs/catalog/hypercube.md closed form, up to overall sign")

    print()
    print("=== Permutohedron (reduced chart -- see reduce_codim1) ===")
    for n in [2, 3, 4]:
        d = n - 1
        y = [var(f"y{i}") for i in range(1, d + 1)]
        pts = reduce_codim1(permutohedron_vertices(n))
        P = Polyhedron(vertices=pts)
        phi = vertex_canonical_form_density(P, y)
        verify_pole_structure(f"Permutohedron n={n}", phi, P, y)

    print()
    print("=== Associahedron (reduced chart -- see reduce_codim1) ===")
    for L in [3, 4, 5]:
        d = L - 2
        y = [var(f"y{i}") for i in range(1, d + 1)]
        pts = reduce_codim1(associahedron_vertices(L))
        P = Polyhedron(vertices=pts)
        phi = vertex_canonical_form_density(P, y)
        verify_pole_structure(f"Associahedron L={L}", phi, P, y)

    print()
    print("=== Non-simple families: out of scope for this formula ===")
    print("Cross-polytope, hypersimplex, and cyclic polytope are SIMPLICIAL")
    print("(their FACETS are simplices), not SIMPLE (their VERTICES don't all")
    print("lie on exactly n facets) -- e.g. every vertex of the octahedron")
    print("(cross-polytope d=3) lies on 4 facets, not 3:")
    try:
        vertex_canonical_form_density(Polyhedron(vertices=cross_polytope_vertices(3)),
                                       [var("y1"), var("y2"), var("y3")])
    except ValueError as e:
        print(f"  -> {e}")
    print("Proposition 6.10 doesn't directly apply to these; the paper's fully")
    print("general Proposition 6.7 (a sum over 'nbc' sets of a hyperplane")
    print("arrangement, with iterated-boundary-map coefficients) does, and IS")
    print("implemented for all of them -- see common.sage's")
    print("general_canonical_form_density and general_canonical_forms.sage.")
