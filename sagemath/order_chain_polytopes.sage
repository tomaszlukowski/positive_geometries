r"""
Verification for the order-polytope / chain-polytope family
(docs/catalog/order-chain-polytopes.md): four example posets spanning the
trivial cases up to a genuine non-combinatorially-equivalent pair, matching
the site's "Example posets" section. Run standalone with
'sage order_chain_polytopes.sage', or via run_all.sage.
"""
try:
    check_fvector
except NameError:
    load("common.sage")

print("=== Order and chain polytopes ===")

def check_volume_conjecture_via_linear_extensions(label, poset):
    """Stanley's theorem: vol(O(P)) = vol(C(P)) = e(P) / |P|!, where e(P)
    is the number of linear extensions of P. Checked directly against
    Sage's own poset.linear_extensions() -- an independent combinatorial
    count, not derived from the polytope at all -- rather than just
    checking O(P) and C(P) agree with each other."""
    n = poset.cardinality()
    e = len(list(poset.linear_extensions()))
    expected = QQ(e) / factorial(n)
    O = Polyhedron(vertices=order_polytope_vertices(poset))
    C = Polyhedron(vertices=chain_polytope_vertices(poset))
    vol_O = O.volume()
    vol_C = C.volume()
    ok = bool(vol_O == expected) and bool(vol_C == expected)
    status = "PASS" if ok else "FAIL"
    print(f"[{status}] {label}: e(P)={e}, |P|!={factorial(n)}, "
          f"e(P)/|P|!={expected}, vol(O)={vol_O}, vol(C)={vol_C}")
    _all_results.append((f"{label} volume = linear extensions / n!", ok))

# 1. Antichain on 3 elements: no relations at all, so both polytopes
# reduce to the 3-cube (every subset is simultaneously an order filter
# and an antichain).
antichain3 = Poset({1: [], 2: [], 3: []})
check_fvector("O(antichain_3)", order_polytope_vertices(antichain3), [8, 12, 6])
check_fvector("C(antichain_3)", chain_polytope_vertices(antichain3), [8, 12, 6])
check_volume("O(antichain_3)", order_polytope_vertices(antichain3), QQ(1))
check_volume("C(antichain_3)", chain_polytope_vertices(antichain3), QQ(1))
check_volume_conjecture_via_linear_extensions("antichain_3", antichain3)

# 2. Chain on 4 elements (totally ordered): both O and C are 4-simplices
# (nested order filters / singleton antichains give n+1 affinely-
# independent 0/1 points either way), volume 1/4!.
chain4 = Poset({1: [2], 2: [3], 3: [4]})
check_fvector("O(chain_4)", order_polytope_vertices(chain4), [5, 10, 10, 5])
check_fvector("C(chain_4)", chain_polytope_vertices(chain4), [5, 10, 10, 5])
check_volume("O(chain_4)", order_polytope_vertices(chain4), QQ(1) / 24)
check_volume("C(chain_4)", chain_polytope_vertices(chain4), QQ(1) / 24)
check_volume_conjecture_via_linear_extensions("chain_4", chain4)

# 3. The "N" (fence) poset on 4 elements: a<c, b<c, b<d. Genuinely
# nontrivial (not a chain or antichain) -- here O and C happen to share
# the same f-vector, not just the same volume.
N = Poset({"a": ["c"], "b": ["c", "d"]})
check_fvector("O(N)", order_polytope_vertices(N), [8, 18, 17, 7])
check_fvector("C(N)", chain_polytope_vertices(N), [8, 18, 17, 7])
check_volume("O(N)", order_polytope_vertices(N), QQ(5) / 24)
check_volume("C(N)", chain_polytope_vertices(N), QQ(5) / 24)
check_volume_conjecture_via_linear_extensions("N", N)

# 4. A graded rank-(2,2,2) poset on 6 elements, complete bipartite between
# consecutive ranks: here O and C have *different* f-vectors beyond f_0
# (found by an exhaustive search over Posets(6) while building this
# family -- this is the general case, not the exception).
double_diamond = Poset({0: [2, 3], 1: [2, 3], 2: [4, 5], 3: [4, 5]})
check_fvector("O(double_diamond)", order_polytope_vertices(double_diamond),
              [10, 39, 77, 82, 46, 12])
check_fvector("C(double_diamond)", chain_polytope_vertices(double_diamond),
              [10, 39, 78, 86, 51, 14])
check_volume("O(double_diamond)", order_polytope_vertices(double_diamond), QQ(1) / 90)
check_volume("C(double_diamond)", chain_polytope_vertices(double_diamond), QQ(1) / 90)
check_volume_conjecture_via_linear_extensions("double_diamond", double_diamond)

# Hibi-Li conjecture (open in general): C(P)'s f-vector dominates O(P)'s,
# entry by entry. Consistent with, not a proof of, the conjecture -- just
# recorded here since it held for every example above.
fO = Polyhedron(vertices=order_polytope_vertices(double_diamond)).f_vector()
fC = Polyhedron(vertices=chain_polytope_vertices(double_diamond)).f_vector()
dominates = all(c >= o for o, c in zip(fO, fC))
print(f"[{'PASS' if dominates else 'FAIL'}] double_diamond: "
      f"C(P) f-vector {tuple(fC)} dominates O(P) f-vector {tuple(fO)} "
      f"(Hibi-Li, checked not assumed)")
_all_results.append(("double_diamond: Hibi-Li f-vector dominance", dominates))

print_summary()
