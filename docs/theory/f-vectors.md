# f-vectors and generating functions

## The f-vector

For a \(d\)-dimensional convex polytope \(P\), the **f-vector**
\((f_0, f_1, \dots, f_{d-1})\) records the number \(f_k\) of
\(k\)-dimensional faces — \(f_0\) vertices, \(f_1\) edges, \(f_{d-1}\)
facets, and so on. It is convenient to set \(f_{-1} = 1\) (the empty
face) and \(f_d = 1\) (the polytope itself), giving the extended f-vector
that appears in the **Euler relation**

\[
\sum_{k=-1}^{d} (-1)^k f_k = 0 \qquad\Longleftrightarrow\qquad
\sum_{k=0}^{d-1} (-1)^k f_k = 1 - (-1)^d.
\]

The f-vector is exactly the data needed to run the recursive definition
of a [positive geometry](positive-geometries.md): it counts, dimension by
dimension, the boundary components that the canonical form must have
simple poles on.

## The f-polynomial

Packaging the f-vector into a single-variable generating function gives
the **f-polynomial**

\[
f_P(y) = \sum_{k=0}^{d-1} f_k\, y^k,
\]

so that, e.g., \(f_P(1)\) counts all proper faces of \(P\). Most of the
families in the [catalog](../catalog/simplex.md) are not a single
polytope but an infinite family \(P_n\) indexed by a parameter \(n\)
(the number of defining points, the dimension, ...), and the natural
object is then a **two-variable generating function** in \(x\) (marking
\(n\)) and \(y\) (marking the face dimension \(k\)):

\[
f(x, y) = \sum_{n} f_{P_n}(y)\, x^n, \qquad\text{or the exponential version}\qquad
\tilde f(x, y) = \sum_{n} f_{P_n}(y)\, \frac{x^n}{n!}.
\]

Every catalog page states \(f(x,y)\) and/or \(\tilde f(x,y)\) in closed
form where one is known, together with the sequence of total face counts
cross-referenced to its entry in the
[OEIS](https://oeis.org). The [data page](../data/f-vector-tables.md)
collects all of them side by side.

!!! note "Convention"
    Both the tables and the generating functions on this site count only
    the *proper* faces \(f_0, \dots, f_{d-1}\) (vertices through facets)
    of the \(d\)-dimensional member of the family — \(y^k\) marks a face
    of dimension \(k\), and \(f(x,1)\) (or \(\tilde f(x,1)\)) sums a
    row of the table exactly. Neither the empty face \(f_{-1}\) nor the
    polytope itself is included.

## Which generating function is "the" natural one

Whether the ordinary (\(x^n\)) or exponential (\(x^n/n!\)) form is the
clean one depends on how fast \(f_k(P_n)\) grows with \(n\): families
built from unordered choices (the simplex's vertex subsets, the
hypercube's coordinate patterns) tend to have rational ordinary
generating functions, while families built from *orderings* — the
permutohedron's vertices are literally the permutations of \(n\) letters,
so \(f_0 = n!\) — grow factorially and only the exponential generating
function stays well-behaved. The [permutohedron page](../catalog/permutohedron.md)
is the clearest example of this: it has a closed-form \(\tilde f(x,y)\)
but no rational \(f(x,y)\).

## References

* [OEIS](https://oeis.org) — the on-line encyclopedia of integer
  sequences; every catalog page links its face-count sequence.
* R. Stanley, *Enumerative Combinatorics, Vol. 1*, for the general theory
  of f-vectors and generating functions used throughout.
