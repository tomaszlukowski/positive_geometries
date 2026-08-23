r"""
Verification for the cyclohedron family (docs/catalog/cyclohedron.md),
n=2,3,4 (dimension n-1) -- same "order n" convention as permutohedron.sage.
Vertices via Devadoss's graph-associahedron construction (common.sage's
cyclohedron_vertices, the graph-associahedron of the n-node cycle graph).
Run standalone with 'sage cyclohedron.sage', or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Cyclohedron ===")

# Devadoss's coordinates live in a hyperplane of R^n -- induced measure,
# same convention as associahedron.sage/permutohedron.sage. f-vector
# checked against the type-B Catalan number C(2n-2,n-1) (vertices) and
# the empirically-found facet count (n-1)*n; volumes computed directly,
# not derived by hand.
for n, f_expected, vol_expected in [(2, [2], AA(2).sqrt()),
                                     (3, [6, 6], 3 * AA(3).sqrt()),
                                     (4, [20, 30, 12], QQ(577) / 3)]:
    label = f"Cyclohedron n={n}"
    pts = cyclohedron_vertices(n)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected, measure='induced')

print_summary()
