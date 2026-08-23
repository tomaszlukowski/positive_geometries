r"""
Verification for the simplex family (docs/catalog/simplex.md), d=1,2,3.
Run standalone with 'sage simplex.sage', or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Simplex ===")

for d, f_expected, vol_expected in [(1, [2], QQ(1)),
                                     (2, [3, 3], QQ(1)/2),
                                     (3, [4, 6, 4], QQ(1)/6)]:
    label = f"Simplex d={d}"
    pts = simplex_vertices(d)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected)

# Canonical form check (d=3): a single simplex is its own only
# triangulation, so this is the direct bracket formula. Compare against
# docs/catalog/simplex.md's closed form 1/(y1 y2 y3 y4), y4=1-y1-y2-y3,
# up to overall orientation sign (the canonical form is only defined up
# to the choice of orientation of X>=0 -- docs/theory/positive-geometries.md).
y = list(var('y1 y2 y3'))
known = 1 / (y[0] * y[1] * y[2] * (1 - y[0] - y[1] - y[2]))
check_canonical_form("Simplex d=3", simplex_vertices(3), known, y)

# Standalone run ('sage simplex.sage'): print this family's rollup now.
# Loaded from run_all.sage instead: it calls print_summary() once at the
# very end, covering every family together.
print_summary()
