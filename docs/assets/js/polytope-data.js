/*
 * Vertex generators for the interactive polytope viewers.
 * Shapes living in R^n (n > 3) are projected onto a fixed orthonormal
 * basis of their affine hull, then rendered with a convex-hull mesh —
 * see polytope-viewer.js.
 */
window.PGPolytopes = (function () {
  "use strict";

  function permutations(arr) {
    if (arr.length <= 1) return [arr.slice()];
    const result = [];
    for (let i = 0; i < arr.length; i++) {
      const rest = arr.slice(0, i).concat(arr.slice(i + 1));
      for (const p of permutations(rest)) result.push([arr[i]].concat(p));
    }
    return result;
  }

  function dot(a, b) {
    let s = 0;
    for (let i = 0; i < a.length; i++) s += a[i] * b[i];
    return s;
  }

  function sub(a, b) {
    return a.map((v, i) => v - b[i]);
  }

  function mean(points) {
    const n = points.length,
      d = points[0].length;
    const m = new Array(d).fill(0);
    for (const p of points) for (let i = 0; i < d; i++) m[i] += p[i] / n;
    return m;
  }

  function normalize(v) {
    const n = Math.sqrt(dot(v, v));
    return v.map((x) => x / n);
  }

  // Project points lying in an affine hyperplane of R^d onto a 3-vector
  // orthonormal basis of that hyperplane's direction space.
  function project(points, basis) {
    const m = mean(points);
    return points.map((p) => {
      const c = sub(p, m);
      return basis.map((b) => dot(c, b));
    });
  }

  // Orthonormal basis of {x in R^4 : sum(x) = const}, reused for both
  // the permutohedron (permutations of 1..4) and the associahedron
  // (Loday coordinates of trees with 5 leaves), since both live in a
  // parallel translate of this hyperplane.
  const HYPERPLANE4_BASIS = [
    normalize([1, -1, 0, 0]),
    normalize([1, 1, -2, 0]),
    normalize([1, 1, 1, -3]),
  ];

  // --- shapes given directly in R^3 -----------------------------------

  function simplexVertices() {
    // regular tetrahedron, inscribed in the cube {-1,1}^3
    return [
      [1, 1, 1],
      [1, -1, -1],
      [-1, 1, -1],
      [-1, -1, 1],
    ];
  }

  function cubeVertices() {
    const v = [];
    for (const x of [-1, 1])
      for (const y of [-1, 1]) for (const z of [-1, 1]) v.push([x, y, z]);
    return v;
  }

  function crossPolytopeVertices() {
    return [
      [1, 0, 0],
      [-1, 0, 0],
      [0, 1, 0],
      [0, -1, 0],
      [0, 0, 1],
      [0, 0, -1],
    ];
  }

  // --- shapes realized in R^4 and projected to R^3 ---------------------

  function permutohedronVertices() {
    const perms = permutations([1, 2, 3, 4]);
    return project(perms, HYPERPLANE4_BASIS);
  }

  // All planar binary trees with `numLeaves` leaves (Catalan(numLeaves-1)
  // of them), represented recursively as null (a leaf) or [left, right].
  function binaryTrees(numLeaves) {
    const memo = new Map();
    function build(n) {
      if (n === 1) return [null];
      if (memo.has(n)) return memo.get(n);
      const trees = [];
      for (let i = 1; i < n; i++) {
        for (const l of build(i)) {
          for (const r of build(n - i)) trees.push([l, r]);
        }
      }
      memo.set(n, trees);
      return trees;
    }
    return build(numLeaves);
  }

  function countLeaves(t) {
    return t === null ? 1 : countLeaves(t[0]) + countLeaves(t[1]);
  }

  // Loday's realization: for a tree with n internal nodes (n+1 leaves),
  // visiting nodes in-order gives a canonical left-to-right indexing of
  // the n internal nodes (shared across all trees). Node i's coordinate
  // is (#leaves in its left subtree) * (#leaves in its right subtree).
  function lodayCoords(tree, numLeaves) {
    const coords = new Array(numLeaves - 1).fill(0);
    let nodeIndex = 0;
    (function visit(t) {
      if (t === null) return;
      visit(t[0]);
      coords[nodeIndex] = countLeaves(t[0]) * countLeaves(t[1]);
      nodeIndex++;
      visit(t[1]);
    })(tree);
    return coords;
  }

  function associahedronVertices() {
    const trees = binaryTrees(5); // Catalan(4) = 14 trees, 4 internal nodes each
    const points = trees.map((t) => lodayCoords(t, 5));
    return project(points, HYPERPLANE4_BASIS);
  }

  return {
    simplex: simplexVertices,
    cube: cubeVertices,
    "cross-polytope": crossPolytopeVertices,
    permutohedron: permutohedronVertices,
    associahedron: associahedronVertices,
  };
})();
