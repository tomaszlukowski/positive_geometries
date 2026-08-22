(* ::Package:: *)

(*
  PositiveGeometries.wl

  An independent (from the SageMath verification/ folder) implementation
  of the vertex embeddings, f-vector computation, volumes, and
  triangulation-based canonical forms used across
  https://tomaszlukowski.github.io/positive_geometries/ -- built so the
  same claims can be checked with a second engine and a genuinely
  different code path.

  All vertex generators use exact integer/rational arithmetic (no
  floating point), matching the coordinates on the site's "Embeddings by
  dimension" sections exactly.

  Load with:  Get["PositiveGeometries.wl"]   (or Needs, if on $Path)
*)

BeginPackage["PositiveGeometries`"]

SimplexVertices::usage =
  "SimplexVertices[d] gives the d+1 vertices of the standard d-simplex \
in the reduced affine chart (the d identity-matrix rows, plus the \
origin), matching docs/catalog/simplex.md.";

HypercubeVertices::usage =
  "HypercubeVertices[d] gives the 2^d vertices of the unit d-cube [0,1]^d.";

CrossPolytopeVertices::usage =
  "CrossPolytopeVertices[d] gives the 2d vertices +-e_i of the \
d-dimensional cross-polytope.";

PermutohedronVertices::usage =
  "PermutohedronVertices[n] gives the n! vertices of the order-n \
permutohedron (every permutation of {1,...,n}), living in the \
hyperplane \[Sum]x_i = n(n+1)/2 in R^n (dimension n-1).";

AssociahedronVertices::usage =
  "AssociahedronVertices[L] gives the Catalan[L-1] vertices of the \
L-leaf associahedron via Loday's coordinates in R^(L-1) (dimension \
L-2): one vertex per planar binary tree with L leaves, coordinate i \
(i-th internal node in in-order) equal to (#leaves left)*(#leaves right).";

HypersimplexVertices::usage =
  "HypersimplexVertices[k,n] gives the Binomial[n,k] vertices of the \
hypersimplex \[CapitalDelta](k,n) -- every 0/1 vector in R^n with \
exactly k ones -- dimension n-1.";

CyclicPolytopeVertices::usage =
  "CyclicPolytopeVertices[n,d] gives the n vertices of the cyclic \
polytope C(n,d): the points (t,t^2,...,t^d) for t = 1,...,n on the \
moment curve.";

FVector::usage =
  "FVector[pts] gives {f0,f1,...,f_{dim-1}}, the number of proper \
faces of each dimension of the convex hull of pts (dim = affine \
dimension of pts), NOT including the empty face or the polytope \
itself -- the same convention as every table on the site.";

PolytopeVolume::usage =
  "PolytopeVolume[pts] gives the Euclidean volume of the convex hull \
of pts.";

PullingTriangulation::usage =
  "PullingTriangulation[pts] triangulates the convex hull of pts \
(which must affinely span R^d, i.e. be given in a full-dimensional/\
reduced chart -- true of every vertex generator in this package) into \
full-dimensional simplices, by recursively coning facets from a fixed \
base vertex (the \"pulling triangulation\"). Returns a list of \
point-lists, each of length d+1.";

SimplexCanonicalFormDensity::usage =
  "SimplexCanonicalFormDensity[vertices, yvars] gives the \
canonical-form density \[Phi](y) of the simplex with the given d+1 \
affine vertices in R^d, as a rational function of yvars, matching the \
bracket formula on docs/catalog/simplex.md: \[Phi](y) = d! Vol / \
\[Product] b_i(y), with b_i the barycentric coordinate functions.";

CanonicalFormDensity::usage =
  "CanonicalFormDensity[pts, yvars] gives the canonical-form density \
of the convex hull of pts, computed by summing \
SimplexCanonicalFormDensity over a PullingTriangulation \
(triangulation-additivity, docs/theory/canonical-forms.md) and \
simplifying. Result should match a family's stated closed form up to \
overall sign (the orientation ambiguity built into the definition of \
a positive geometry's canonical form).";

PolarDual::usage =
  "PolarDual[pts] gives the vertices of the polar dual of the convex \
hull of pts, computed from each facet's supporting hyperplane. \
Assumes the origin is in the strict interior of the hull (translate \
pts first if not, e.g. PolarDual[HypercubeVertices[3] - 1/2]).";

Begin["`Private`"]

(* ------------------------------------------------------------------ *)
(* Vertex generators                                                   *)
(* ------------------------------------------------------------------ *)

SimplexVertices[d_Integer?Positive] :=
  Append[IdentityMatrix[d], ConstantArray[0, d]];

HypercubeVertices[d_Integer?Positive] := Tuples[{0, 1}, d];

CrossPolytopeVertices[d_Integer?Positive] :=
  Flatten[Table[{UnitVector[d, i], -UnitVector[d, i]}, {i, d}], 1];

PermutohedronVertices[n_Integer?Positive] := Permutations[Range[n]];

(* Loday's coordinates for the associahedron: trees are represented as
   `Leaf` or `Node[left, right]`. *)
countLeaves[Leaf] = 1;
countLeaves[Node[l_, r_]] := countLeaves[l] + countLeaves[r];

binaryTrees[1] := {Leaf};
binaryTrees[n_Integer] := binaryTrees[n] =
  (* full flatten (no level spec): every leaf here is Node[...] or Leaf,
     never a List, so Flatten can't over-merge -- safer than guessing
     the exact nesting depth Table+Outer produces. *)
  Flatten[Table[Outer[Node, binaryTrees[i], binaryTrees[n - i]], {i, 1, n - 1}]];

lodayCoords[tree_, numLeaves_Integer] := Module[{coords, idx = 1, visit},
  coords = ConstantArray[0, numLeaves - 1];
  visit[Leaf] := Null;
  visit[Node[l_, r_]] := (
    visit[l];
    coords[[idx]] = countLeaves[l]*countLeaves[r];
    idx++;
    visit[r];
  );
  visit[tree];
  coords
];

AssociahedronVertices[L_Integer?Positive] :=
  lodayCoords[#, L] & /@ binaryTrees[L];

(* Named (not nested-#) on purpose: `Total[UnitVector[n,#]&/@#]&/@subsets`
   would rely on the outer and inner # correctly resolving to different
   scopes -- legal, but exactly the kind of nested-#/& construct worth
   just not writing. *)
HypersimplexVertices[k_Integer, n_Integer] := Module[{subsetToVertex},
  subsetToVertex[S_List] := Total[UnitVector[n, #] & /@ S];
  subsetToVertex /@ Subsets[Range[n], {k}]
];

CyclicPolytopeVertices[n_Integer, d_Integer] :=
  Table[t^Range[d], {t, 1, n}];

(* ------------------------------------------------------------------ *)
(* f-vector and volume                                                 *)
(* ------------------------------------------------------------------ *)

FVector[pts_List] := Module[{mesh, dim},
  mesh = ConvexHullMesh[pts];
  dim = RegionDimension[mesh];
  Table[MeshCellCount[mesh, k], {k, 0, dim - 1}]
];

PolytopeVolume[pts_List] := Volume[ConvexHullMesh[pts]];

(* ------------------------------------------------------------------ *)
(* Pulling triangulation                                               *)
(* ------------------------------------------------------------------ *)

cellIndices[cell_] := List @@ First[cell];

pullingTriangulationRec[pts_List, dim_Integer] := Module[
  {mesh, coords, facetCells, base, facets, result = {}},
  If[Length[pts] == dim + 1, Return[{pts}]];
  mesh = ConvexHullMesh[pts];
  coords = MeshCoordinates[mesh];
  facetCells = MeshCells[mesh, dim - 1];
  base = First[pts];
  facets = Select[coords[[cellIndices[#]]] & /@ facetCells,
    ! MemberQ[#, base, 1] &];
  Do[
    Module[{subSimplices},
      subSimplices = If[Length[facet] == dim,
        {facet},
        pullingTriangulationRec[facet, dim - 1]
      ];
      result = Join[result, (Append[#, base] &) /@ subSimplices];
    ],
    {facet, facets}
  ];
  result
];

PullingTriangulation[pts_List] :=
  pullingTriangulationRec[pts, Length[First[pts]]];

(* ------------------------------------------------------------------ *)
(* Canonical forms                                                     *)
(* ------------------------------------------------------------------ *)

SimplexCanonicalFormDensity[vertices_List, yvars_List] := Module[
  {d = Length[yvars], edgeMatrix, numerator, M, Minv, oneY, b, denom},
  edgeMatrix = Table[vertices[[i + 1]] - vertices[[1]], {i, d}];
  numerator = Abs[Det[edgeMatrix]];
  M = Prepend[#, 1] & /@ vertices;
  Minv = Inverse[M];
  oneY = Prepend[yvars, 1];
  b = Transpose[Minv].oneY;
  denom = Times @@ b;
  numerator/denom
];

CanonicalFormDensity[pts_List, yvars_List] := Module[{simplices},
  simplices = PullingTriangulation[pts];
  Simplify[Total[SimplexCanonicalFormDensity[#, yvars] & /@ simplices]]
];

(* ------------------------------------------------------------------ *)
(* Polar dual                                                          *)
(* ------------------------------------------------------------------ *)

PolarDual[pts_List] := Module[
  {mesh, dim, coords, facetCells, nsym, nvec},
  mesh = ConvexHullMesh[pts];
  dim = RegionDimension[mesh];
  coords = MeshCoordinates[mesh];
  facetCells = MeshCells[mesh, dim - 1];
  nvec = Array[nsym, dim];
  DeleteDuplicates[
    Table[
      Module[{facetPts, basePts, sol},
        facetPts = coords[[cellIndices[cell]]];
        basePts = Take[facetPts, dim];
        sol = Solve[(nvec.# == 1) & /@ basePts, nvec];
        nvec /. First[sol]
      ],
      {cell, facetCells}
    ]
  ]
];

End[]

EndPackage[]
