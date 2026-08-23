r"""
Verification for the associahedron family (docs/catalog/associahedron.md),
L=3,4,5 leaves (dimension L-2). Run standalone with 'sage associahedron.sage',
or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Associahedron ===")

# Loday's coordinates live in a hyperplane of R^(L-1) -- induced measure
# again. L=4's volume isn't a clean closed form (left as None -> printed,
# not asserted); independently-computed reference value ~6.0621778.
for L, f_expected, vol_expected in [(3, [2], AA(2).sqrt()),
                                     (4, [5, 5], None),
                                     (5, [14, 21, 9], QQ(142)/3)]:
    label = f"Associahedron L={L}"
    pts = associahedron_vertices(L)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected, measure='induced')

print_summary()
