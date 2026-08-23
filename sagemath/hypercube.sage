r"""
Verification for the hypercube family (docs/catalog/hypercube.md), d=1,2,3.
Run standalone with 'sage hypercube.sage', or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Hypercube ===")

for d, f_expected, vol_expected in [(1, [2], QQ(1)),
                                     (2, [4, 4], QQ(1)),
                                     (3, [8, 12, 6], QQ(1))]:
    label = f"Hypercube d={d}"
    pts = hypercube_vertices(d)
    check_fvector(label, pts, f_expected)
    check_volume(label, pts, vol_expected)

# Canonical form check (d=3), via TOPCOM's placing triangulation. Compare
# against docs/catalog/hypercube.md's closed form
# 1/(y1(y1-1) y2(y2-1) y3(y3-1)), up to overall sign.
y = list(var('y1 y2 y3'))
known = 1 / prod(y[i] * (y[i] - 1) for i in range(3))
check_canonical_form("Hypercube d=3", hypercube_vertices(3), known, y)

# Dual check (d=3): polar of the CENTERED cube should be combinatorially
# the octahedron (cross-polytope) -- docs/catalog/hypercube.md.
centered_cube = [tuple(x - QQ(1)/2 for x in v) for v in hypercube_vertices(3)]
dual = Polyhedron(vertices=centered_cube).polar()
dual_f = tuple(dual.f_vector()[1:-1])
dual_ok = (dual_f == (6, 12, 8))
print(f"[{'PASS' if dual_ok else 'FAIL'}] Hypercube d=3 dual is the octahedron  "
      f"dual f-vector={dual_f}  expected=(6, 12, 8)")
_all_results.append(("Hypercube d=3 dual is the octahedron", dual_ok))

print_summary()
