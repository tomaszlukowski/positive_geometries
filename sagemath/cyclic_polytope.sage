r"""
Verification for the cyclic polytope family (docs/catalog/cyclic-polytope.md),
the n=d+3 slice C(5,2), C(6,3), C(7,4), matching the site's "Embeddings by
dimension" section. Run standalone with 'sage cyclic_polytope.sage', or
via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Cyclic polytope ===")

for (n, d), f_expected, vol_expected in [((5, 2), [5, 5], QQ(10)),
                                          ((6, 3), [6, 12, 8], QQ(70)),
                                          ((7, 4), [7, 21, 28, 14], QQ(1512))]:
    label = f"Cyclic polytope C({n},{d})"
    pts = cyclic_polytope_vertices(n, d)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected)

print_summary()
