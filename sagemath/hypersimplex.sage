r"""
Verification for the hypersimplex family (docs/catalog/hypersimplex.md),
the k=2 slice Delta(2,4), Delta(2,5), Delta(2,6) (dimension n-1), matching
the site's "Embeddings by dimension" section. Run standalone with
'sage hypersimplex.sage', or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Hypersimplex ===")

# Delta(2,n) lives in a hyperplane of R^n -- induced measure again. n=5,6's
# volumes aren't clean closed forms here; independently-computed reference
# values ~1.0248645 and ~0.5307228 respectively.
for n, f_expected, vol_expected in [(4, [6, 12, 8], QQ(4)/3),
                                     (5, [10, 30, 30, 10], None),
                                     (6, [15, 60, 80, 45, 12], None)]:
    label = f"Hypersimplex Delta(2,{n})"
    pts = hypersimplex_vertices(2, n)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected, measure='induced')

print_summary()
