r"""
Verification for the cross-polytope family (docs/catalog/cross-polytope.md), d=1,2,3.
Run standalone with 'sage cross_polytope.sage', or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Cross-polytope ===")

for d, f_expected, vol_expected in [(1, [2], QQ(2)),
                                     (2, [4, 4], QQ(2)),
                                     (3, [6, 12, 8], QQ(4)/3)]:
    label = f"Cross-polytope d={d}"
    pts = cross_polytope_vertices(d)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected)

print_summary()
