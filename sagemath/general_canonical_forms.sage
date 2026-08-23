r"""
general_canonical_forms.sage

Computes the canonical form of ANY full-dimensional convex polytope --
simple or not -- as a sum over "non-broken-circuit" (nbc) contributions,
using

    F. Brown, C. Dupont, "Positive geometries and canonical forms via
    mixed Hodge theory", arXiv:2501.03202, Section 6 (Proposition 6.7,
    specialized to a bounded region as in Section 6.7 "Convex polyhedra").

This generalizes vertex_sum_canonical_forms.sage (Proposition 6.10),
which only covers SIMPLE polytopes. Run standalone with
'sage general_canonical_forms.sage'.

-----------------------------------------------------------------------
The method
-----------------------------------------------------------------------
Fix a linear order H_1,...,H_N on the facet hyperplanes of P (here: the
order Sage's Polyhedron.Hrepresentation() returns them in, unless an
explicit 'order' is passed). For a set I = {i_1<...<i_n} of n indices
such that H_{i_1},...,H_{i_n} are linearly independent, write H_I for
their common point, and

    omega_I := omega_{i_1} ^ ... ^ omega_{i_n},   omega_i := dlog(f_i),

with f_i the affine function cutting out H_i (f_i >= 0 on P). Proposition
6.7 states

    omega_P = sum_{I nbc, |I|=n}  d_I(P)  omega_I,

summed over I that are NON-BROKEN-CIRCUIT (nbc) sets of the hyperplane
arrangement -- see "Combinatorics" below -- where d_I(P) in {-1,0,1} is
an ITERATED BOUNDARY MAP: process the indices of I from LARGEST to
SMALLEST, at each step intersecting the current face with the next
hyperplane; d_I(P) is 0 unless this produces a genuine chain of facets
all the way down to the point H_I (a "flag" in P's face lattice), in
which case it is +-1.

For a SIMPLE polytope, every vertex has exactly n facets through it, so
there is exactly one candidate I per vertex, it is automatically nbc,
and the flag always exists -- this is exactly Proposition 6.10. For a
non-simple vertex (more than n facets meet there), several different nbc
sets I can share the same H_I = v, and the flag condition genuinely
filters some of them out -- see the square-pyramid example below (its
apex has 4 facets meeting, giving 3 nbc candidates, of which only 2
produce a valid flag).

-----------------------------------------------------------------------
Combinatorics: circuits, broken circuits, nbc sets -- via matroid theory
-----------------------------------------------------------------------
Whether H_{i_1},...,H_{i_k} are linearly dependent is a question about
the vectors (b_i, a_i) in Q^{n+1} (f_i(x) = b_i + a_i . x): a MINIMAL
dependent subset is a "circuit". This is exactly a LINEAR MATROID, so
Sage's own Matroid class computes circuits directly -- no need to
hand-roll that combinatorics. A "broken circuit" is a circuit with its
smallest element (in the fixed order) removed; an "nbc set" contains no
broken circuit. Since a candidate I with H_I = v must consist entirely
of facets through v, all the relevant circuits are already contained in
the LOCAL matroid on {facets through v} -- so this is computed per
vertex, not once for the whole (possibly large) global arrangement.

-----------------------------------------------------------------------
The sign, and a clean closed form for the density (derived and checked
against the paper's own square-pyramid example below, not assumed)
-----------------------------------------------------------------------
As in vertex_sum_canonical_forms.sage, omega_I's DENSITY (coefficient of
dy_1^...^dy_n) is det(A_I) / prod_i f_i(y), with A_I the matrix of the
a_i (any fixed order -- reordering I only flips this sign the same way
it flips det). Empirically (verified below against the paper's exact
stated formula for the square pyramid, term by term, not just up to
overall sign), d_I(P) equals exactly sign(det(A_I)) whenever the flag
exists. Since sign(det(A_I)) * det(A_I) = |det(A_I)|, this collapses to

    phi(y) = (-1)^(n(n+1)/2) * sum_v sum_{I nbc at v, flag valid}
                 |det(A_I)(y)| / prod_{i in I} f_i(y),

exactly generalizing Proposition 6.10's formula (which is the special
case where every vertex contributes exactly one term).
"""

try:
    check_fvector
except NameError:
    load("common.sage")


def facet_data(P, order=None):
    r"""List of (b_i, a_i, Hrepresentation_object) for each facet of P, in
    a fixed order (Sage's own order by default, or 'order': an explicit
    list of Hrepresentation objects, e.g. to match a paper's labeling)."""
    hreps = order if order is not None else list(P.Hrepresentation())
    return [(h.b(), vector(QQ, h.A()), h) for h in hreps]


def vertex_local_indices(v, fdata):
    r"""Positions (into fdata) of the facets containing vertex v."""
    incident = set(v.incident())
    return [i for i, (b, a, h) in enumerate(fdata) if h in incident]


def local_matroid(fdata, S_v):
    r"""Linear matroid on the homogeneous vectors (b_i,a_i), i in S_v."""
    cols = [vector(QQ, [fdata[i][0]] + list(fdata[i][1])) for i in S_v]
    return Matroid(matrix=matrix(QQ, cols).transpose())


def nbc_bases(fdata, S_v):
    r"""n-element subsets of S_v (as sorted tuples of GLOBAL indices) that
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
    r"""I_sorted: increasing tuple of n global facet indices. Processes
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


def general_canonical_form_density(P, y_vars, order=None):
    r"""Proposition 6.7: canonical-form density of ANY full-dimensional
    convex polytope P (simple or not), as a sum over nbc sets with
    nonzero iterated-boundary coefficient."""
    n = P.dimension()
    if len(y_vars) != n:
        raise ValueError(f"P has dimension {n} but {len(y_vars)} y-variables were given")
    fdata = facet_data(P, order=order)
    total = SR(0)
    for v in P.vertex_generator():
        S_v = vertex_local_indices(v, fdata)
        for I in nbc_bases(fdata, S_v):
            if flag_sign(P, I, fdata) == 0:
                continue
            A = matrix(QQ, [fdata[i][1] for i in I])
            det_abs = abs(A.det())
            f_list = [fdata[i][0] + sum(QQ(fdata[i][1][j]) * y_vars[j] for j in range(n))
                      for i in I]
            total += det_abs / prod(f_list)
    sign_const = (-1) ** (n * (n + 1) // 2)
    return (sign_const * total).simplify_full()


def reduce_codim1(pts):
    r"""Drop the last ambient coordinate -- see vertex_sum_canonical_forms.sage."""
    N = len(pts[0])
    return [tuple(p[:N - 1]) for p in pts]


def verify_pole_structure(label, phi, P, y_vars):
    r"""The defining property of a canonical form: simple poles exactly
    on P's own facets, nothing else."""
    R = PolynomialRing(QQ, [str(v) for v in y_vars])
    _, den = phi.numerator_denominator()
    factors = list(R(den).factor())
    ok = (len(factors) == P.n_facets()) and all(m == 1 for _, m in factors)
    print(f"[{'PASS' if ok else 'FAIL'}] {label}: {len(factors)} pole factors "
          f"(expected {P.n_facets()} facets), all simple: {all(m == 1 for _, m in factors)}")
    return ok


if True:
    print("=== Reproducing the paper's own worked example: the square pyramid (Sec. 6.7) ===")
    print("H1={x=z}, H2={y=z}, H3={x=-z}, H4={y=-z}, H5={z=-1}")
    ieqs = [
        [0, 1, 0, -1],   # H1: x - z >= 0
        [0, 0, 1, -1],   # H2: y - z >= 0
        [0, -1, 0, -1],  # H3: -x - z >= 0
        [0, 0, -1, -1],  # H4: -y - z >= 0
        [1, 0, 0, 1],    # H5: z + 1 >= 0
    ]
    pyramid = Polyhedron(ieqs=ieqs)
    hrep_list = list(pyramid.Hrepresentation())

    def _find(bA):
        b, a = bA[0], bA[1:]
        return next(h for h in hrep_list if h.b() == b and tuple(h.A()) == tuple(a))

    paper_order = [_find(v) for v in ieqs]
    y = [var("y1"), var("y2"), var("y3")]
    phi_pyr = general_canonical_form_density(pyramid, y, order=paper_order)
    # The paper's exact stated formula (page 48):
    #   omega_P = -w1^w2^w3 - w1^w3^w4 + w1^w2^w5 + w2^w3^w5 + w3^w4^w5 - w1^w4^w5
    # Each w_I's DENSITY is det(A_I)/prod(f_i) (see the derivation above),
    # not just 1/prod(f_i) -- omega_density below builds that correctly.
    f = [paper_order[i].b() + sum(QQ(paper_order[i].A()[j]) * y[j] for j in range(3))
         for i in range(5)]

    def omega_density(I):
        A = matrix(QQ, [paper_order[i - 1].A() for i in I])
        return A.det() / prod(f[i - 1] for i in I)

    known_pyr = (-omega_density((1, 2, 3)) - omega_density((1, 3, 4))
                 + omega_density((1, 2, 5)) + omega_density((2, 3, 5))
                 + omega_density((3, 4, 5)) - omega_density((1, 4, 5)))
    match = (phi_pyr - known_pyr).simplify_full() == 0
    print(f"[{'PASS' if match else 'FAIL'}] matches the paper's exact stated formula "
          f"(not just up to sign -- the paper's own orientation convention, "
          f"reproduced exactly)")
    verify_pole_structure("Square pyramid", phi_pyr, pyramid, y)

    print()
    print("=== Cross-check: simple polytopes should agree with Prop. 6.10 (vertex_sum_canonical_forms.sage) ===")
    load("vertex_sum_canonical_forms.sage")
    for label, pts in [("Simplex d=3", simplex_vertices(3)),
                        ("Hypercube d=3", hypercube_vertices(3))]:
        P = Polyhedron(vertices=pts)
        phi_general = general_canonical_form_density(P, y)
        phi_simple = vertex_canonical_form_density(P, y)
        agree = (phi_general - phi_simple).simplify_full() == 0
        print(f"[{'PASS' if agree else 'FAIL'}] {label}: general method matches Prop. 6.10 exactly")

    print()
    print("=== Cross-polytope (simplicial, NOT simple) ===")
    for d in [1, 2, 3]:
        yv = [var(f"y{i}") for i in range(1, d + 1)]
        P = Polyhedron(vertices=cross_polytope_vertices(d))
        phi = general_canonical_form_density(P, yv)
        verify_pole_structure(f"Cross-polytope d={d}", phi, P, yv)

    print()
    print("=== Hypersimplex Delta(2,n) (reduced chart -- NOT simple) ===")
    for n in [4, 5]:
        d = n - 1
        yv = [var(f"y{i}") for i in range(1, d + 1)]
        pts = reduce_codim1(hypersimplex_vertices(2, n))
        P = Polyhedron(vertices=pts)
        phi = general_canonical_form_density(P, yv)
        verify_pole_structure(f"Hypersimplex Delta(2,{n})", phi, P, yv)

    print()
    print("=== Cyclic polytope (simplicial, NOT simple for d>=4) ===")
    for (n, d) in [(5, 2), (6, 3), (7, 4)]:
        yv = [var(f"y{i}") for i in range(1, d + 1)]
        P = Polyhedron(vertices=cyclic_polytope_vertices(n, d))
        phi = general_canonical_form_density(P, yv)
        verify_pole_structure(f"Cyclic polytope C({n},{d})", phi, P, yv)
