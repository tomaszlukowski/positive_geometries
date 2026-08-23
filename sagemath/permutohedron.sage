r"""
Verification for the permutohedron family (docs/catalog/permutohedron.md),
n=2,3,4 (dimension n-1). Run standalone with 'sage permutohedron.sage',
or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Permutohedron ===")

# Pi_(n-1) lives in a hyperplane of R^n, so it is NOT full-dimensional in
# its ambient space -- use the induced (intrinsic) Euclidean measure, not
# the (zero) ambient one.
for n, f_expected, vol_expected in [(2, [2], AA(2).sqrt()),
                                     (3, [6, 6], AA(27).sqrt()),
                                     (4, [24, 36, 14], QQ(32))]:
    label = f"Permutohedron n={n}"
    pts = permutohedron_vertices(n)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected, measure='induced')

print_summary()
