# Positive geometries

## Definition

A **positive geometry** of dimension \(D\) is a pair \((X, X_{\geq 0})\)
consisting of

* a complex projective algebraic variety \(X\) of complex dimension \(D\), and
* an oriented, closed subset \(X_{\geq 0}\) of the real points of \(X\)
  with real dimension \(D\) (the *positive part*),

for which a unique rational top-form \(\Omega(X, X_{\geq 0})\), the
**canonical form**, exists satisfying the recursive boundary axiom below.
The pair \((X, X_{\geq 0})\) together with this form is what is meant by a
positive geometry; \(X_{\geq 0}\) alone is sometimes loosely called "the"
positive geometry when \(X\) and the form are clear from context.

The definition, and the term itself, is due to Arkani-Hamed, Bai and Lam
(arXiv:1703.04541); it abstracts a pattern first observed for the
amplituhedron (arXiv:1312.2007) and, much earlier, for the simplex and
its generalizations in the theory of convex polytopes.

## The recursive boundary axiom

The canonical form is pinned down by induction on \(D\).

**Base case \((D = 0)\).** Here \(X = X_{\geq 0}\) is a single, oriented
real point, and \(\Omega(X, X_{\geq 0}) = +1\) or \(-1\) according to its
orientation.

**Inductive step \((D > 0)\).** The boundary \(\partial X_{\geq 0}\)
decomposes into finitely many irreducible components \(C\), each of real
dimension \(D-1\). \((X, X_{\geq 0})\) is a positive geometry with
canonical form \(\Omega(X, X_{\geq 0})\) if:

1. Each boundary component \(C\), together with an orientation induced
   from \(X_{\geq 0}\), is itself a positive geometry \((C, C_{\geq 0})\)
   of dimension \(D - 1\) (with its own canonical form
   \(\Omega(C, C_{\geq 0})\), already determined by induction);
2. \(\Omega(X, X_{\geq 0})\) is a rational top-form on \(X\) with poles
   *at most* along the boundary components \(C\), all simple
   (logarithmic), and no poles anywhere else on \(X\);
3. along every boundary component \(C\), the residue of \(\Omega\)
   reproduces the lower-dimensional canonical form exactly,
   \(\Res_{C}\, \Omega(X, X_{\geq 0}) \;=\; \Omega(C, C_{\geq 0})\).

Existence is not automatic — most varieties admit no such form — but when
it exists, it is unique: two top-forms with the same simple poles and the
same residues along every pole differ by a holomorphic top-form, and a
projective variety has none.

## Polytopes as the founding example

A convex polytope \(P \subset \RR^D\) (or, projectively, in \(\PP^D\))
is a positive geometry with \(X = \PP^D\) (or a suitable ambient variety)
and \(X_{\geq 0} = P\). Its boundary components are exactly its facets,
each of which is again a polytope, so the recursion bottoms out at the
vertices, matching the base case. Every example in the [catalog](../catalog/simplex.md)
is of this kind, and every catalog page states its canonical form
explicitly. See [Canonical forms](canonical-forms.md) for how the residue
axiom is actually solved in practice, and [f-vectors](f-vectors.md) for
the combinatorics of the boundary stratification itself.

Positive geometries are strictly more general than polytopes: the
Grassmannian's positive part, the amplituhedron, and the ABHY
associahedron (a curved deformation of the ordinary associahedron cut out
by more general kinematic constraints) are all positive geometries whose
\(X\) is not simply projective space. This site's catalog stays polytopal;
see [Physics motivation](physics-motivation.md) for a pointer to the
non-polytopal examples.

## References

* N. Arkani-Hamed, Y. Bai, T. Lam, *Positive Geometries and Canonical
  Forms*, [arXiv:1703.04541](https://arxiv.org/abs/1703.04541).
* N. Arkani-Hamed, J. Trnka, *The Amplituhedron*,
  [arXiv:1312.2007](https://arxiv.org/abs/1312.2007).

See the full [references](../references.md) page for more.
