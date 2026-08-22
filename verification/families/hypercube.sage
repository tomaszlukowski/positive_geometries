r"""
Verification for the hypercube family (docs/catalog/hypercube.md), at
n=3 (the cube shown in the site's interactive viewer). Run:

    sage verification/families/hypercube.sage
"""
load("common/canonical_forms.sage")

print("=== Hypercube K_3^(0) = [0,1]^3 ===")
pts = [(0, 0, 0), (1, 0, 0), (0, 1, 0), (1, 1, 0),
       (0, 0, 1), (1, 0, 1), (0, 1, 1), (1, 1, 1)]
P = Polyhedron(vertices=pts)
print("vertices:", P.vertices_list())
print("f-vector:", P.f_vector())
print("volume:", P.volume())

# The polar dual needs the origin in the interior -- use the centered cube.
pts_centered = [(x - 1/2, y - 1/2, z - 1/2) for (x, y, z) in pts]
Pc = Polyhedron(vertices=pts_centered)
D = Pc.polar()
print("dual (of the centered cube) vertices:", D.vertices_list())
print("dual f-vector:", D.f_vector())
print("dual volume:", D.volume())
print("  -> combinatorially the octahedron / cross-polytope, as claimed on the site")

y = list(var('y1 y2 y3'))
pc = PointConfiguration(pts)
tri1 = list(pc.triangulate())
phi1 = triangulation_density(tri1, pts, y)
print("triangulation 1 (", len(tri1), "simplices ):", tri1)
print("density from triangulation 1:", phi1)

known = 1 / prod(y[i] * (y[i] - 1) for i in range(3))
report_equal_up_to_sign(
    "hypercube canonical form matches site's closed form", phi1, known,
)

all_tris = pc.triangulations_list()
print("total triangulations of the cube (TOPCOM):", len(all_tris))
tri2 = list(all_tris[len(all_tris) // 2])
phi2 = triangulation_density(tri2, pts, y)
report_equal(
    "two different triangulations give identical densities "
    "(triangulation-independence)", phi1, phi2,
)

SP = pc.secondary_polytope()
print("secondary polytope dimension:", SP.dimension())
print("secondary polytope f-vector:", SP.f_vector())
print("secondary polytope vertex count "
      "(== number of *regular* triangulations):", len(SP.vertices()))
