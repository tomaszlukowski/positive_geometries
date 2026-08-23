r"""
Verification for the Birkhoff polytope family (docs/catalog/birkhoff.md),
n = 2, 3 (dimension (n-1)^2), matching the site's "Embeddings by
dimension" section, plus f-vector/volume only at n=4 (canonical form and
triangulations were measured infeasible there -- see the notebook). Run
standalone with 'sage birkhoff.sage', or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Birkhoff polytope ===")

for n, f_expected, vol_expected in [(2, [2], QQ(1)),
                                     (3, [6, 15, 18, 9], QQ(1) / 8),
                                     (4, [24, 240, 978, 1968, 2176, 1392, 528, 120, 16],
                                      QQ(11) / 11340)]:
    label = f"Birkhoff B_{n}"
    pts = reduce_full_dim(birkhoff_vertices(n))
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected, measure='induced')

print_summary()
