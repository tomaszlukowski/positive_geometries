r"""
Runs every family script in this directory in one session and prints one
combined summary at the end covering every check. Run with:

    sage run_all.sage
"""
load("common.sage")

load("simplex.sage")
load("hypercube.sage")
load("cross_polytope.sage")
load("permutohedron.sage")
load("associahedron.sage")
load("hypersimplex.sage")
load("cyclic_polytope.sage")
load("cyclohedron.sage")
load("stellohedron.sage")
load("order_chain_polytopes.sage")

print()
print("############################################")
print("# FINAL COMBINED SUMMARY (all families)")
print("############################################")
all_ok = print_summary()
if not all_ok:
    import sys
    sys.exit(1)
