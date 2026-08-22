r"""
Verification for the simplex family (docs/catalog/simplex.md).

Uses S_4^(0) = conv{e1, e2, e3, e4} in the reduced chart where
y1, y2, y3 are independent and y4 = 1 - y1 - y2 - y3 is implicit
(matching the affine chart the site's canonical-form formula is stated
in). Run:

    sage verification/families/simplex.sage
"""
load("common/canonical_forms.sage")

print("=== Simplex S_4^(0) = conv{e1,e2,e3,e4} subset R^4, d=3 ===")
print("(reduced chart: y1,y2,y3 independent, y4 = 1-y1-y2-y3 implicit)")

verts = [(1, 0, 0), (0, 1, 0), (0, 0, 1), (0, 0, 0)]  # e1,e2,e3,e4
P = Polyhedron(vertices=verts)
print("vertices:", P.vertices_list())
print("f-vector:", P.f_vector())
print("volume:", P.volume())

y = list(var('y1 y2 y3'))
phi = simplex_density(verts, y)
print("computed canonical-form density:", phi)

known = 1 / (y[0] * y[1] * y[2] * (1 - y[0] - y[1] - y[2]))
report_equal_up_to_sign(
    "simplex canonical form matches site's closed form 1/(y1 y2 y3 y4)",
    phi, known,
)
