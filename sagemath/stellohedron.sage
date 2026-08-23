r"""
Verification for the stellohedron family (docs/catalog/stellohedron.md),
n=1,2,3 (dimension n, one center + n leaves). Vertices via Devadoss's
graph-associahedron construction (common.sage's stellohedron_vertices,
the graph-associahedron of the star graph on n+1 nodes). Run standalone
with 'sage stellohedron.sage', or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Stellohedron ===")

# Devadoss's coordinates live in a hyperplane of R^(n+1) -- induced
# measure, same convention as the other graph-associahedron family
# (cyclohedron.sage). f-vector checked against OEIS A000522 (vertices);
# n=2's volume numerically matches the associahedron's own L=4 pentagon
# (both are combinatorially pentagons) but isn't asserted here for the
# same reason associahedron.sage leaves that one unlisted: no clean
# closed form found yet, just the computed irrational value.
for n, f_expected, vol_expected in [(1, [2], AA(2).sqrt()),
                                     (2, [5, 5], None),
                                     (3, [16, 24, 10], QQ(205))]:
    label = f"Stellohedron n={n}"
    pts = stellohedron_vertices(n)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected, measure='induced')

print_summary()
