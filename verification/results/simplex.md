# Simplex — verification results

Computed with `verification/families/simplex.sage`, SageMath 10.9, exact
rational arithmetic throughout.

## Instance

\(S_4^{(0)} = \conv\{e_1, e_2, e_3, e_4\} \subset \RR^4\), reduced to the
affine chart \(y_1, y_2, y_3\) (independent) with
\(y_4 = 1 - y_1 - y_2 - y_3\) implicit — the same chart
[docs/catalog/simplex.md](../../docs/catalog/simplex.md) states its
canonical form in.

## Vertices (in this chart)

\((1,0,0),\ (0,1,0),\ (0,0,1),\ (0,0,0)\)

## f-vector

\((1, 4, 6, 4, 1)\) — matches the site's table (4 vertices, 6 edges, 4
facets).

## Volume

\(\mathrm{Vol}(S_4^{(0)}) = 1/6\) — exact, via Sage's `Polyhedron.volume()`.

## Canonical form

Computed directly as a single simplex (no triangulation needed):

\[
\phi(y) = \frac{-1}{y_1\, y_2\, y_3\, (y_1+y_2+y_3-1)}
\]

Site's closed form: \(1/(y_1 y_2 y_3 y_4)\) with
\(y_4 = 1-y_1-y_2-y_3\), i.e. \(1/(y_1 y_2 y_3 (1-y_1-y_2-y_3))\).

**Result: matches up to the overall orientation sign** — i.e. the two
differ by exactly \((-1)\), which is expected and immaterial (the
canonical form is only defined up to the choice of orientation of
\(X_{\geq 0}\); see
[theory/positive-geometries.md](../../docs/theory/positive-geometries.md)).
The magnitude and pole structure match exactly. **PASS.**
