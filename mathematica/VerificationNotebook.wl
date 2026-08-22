(* ::Package:: *)

(* ::Title:: *)
(*Positive Geometries \[Dash] Mathematica verification notebook*)

(* ::Text:: *)
(*Independent (from the SageMath verification/ folder) checks of the vertex embeddings, f-vectors, volumes, and canonical forms published at https://tomaszlukowski.github.io/positive_geometries/, using PositiveGeometries.wl \[Dash] a from-scratch Mathematica implementation, not a port that shares bugs with the Sage code.*)

(* ::Text:: *)
(*Every "expected" value below was worked out independently ahead of time (either directly from the published closed-form combinatorial formulas, or via SageMath's exact Polyhedron.f_vector()/volume() \[Dash] see verification/results/*.md). Running the cells below checks a THIRD, independent computation (Mathematica's own ConvexHullMesh/MeshCellCount) against those values. If everything reports True, three independent methods agree.*)

(* ::Text:: *)
(*This file is plain Wolfram Language source with cell-style markers, so it opens as a formatted notebook in the Mathematica front end (File > Open), and is also directly runnable headlessly, e.g. wolframscript -file VerificationNotebook.wl.*)

(* ::Section:: *)
(*Setup*)

(* ::Text:: *)
(*Works both as an opened notebook (NotebookDirectory[]) and run headlessly, e.g. wolframscript -file VerificationNotebook.wl (NotebookDirectory[] returns $Failed there, so this falls back to the running script's own directory).*)

(* ::Input:: *)
(*scriptDir = Which[
  $InputFileName =!= "", DirectoryName[$InputFileName],
  Quiet[NotebookDirectory[]] =!= $Failed, NotebookDirectory[],
  True, Directory[]
];*)
(*SetDirectory[scriptDir];*)
(*Get["PositiveGeometries.wl"];*)
(*$allResults = {};*)

(* ::Text:: *)
(*checkInstance computes the f-vector and volume of one instance, prints both alongside the expected values, and records a pass/fail boolean for each in $allResults (read out in the Summary section at the end). Pass expectedVol -> None to skip the volume check for an instance where this notebook doesn't assert a specific closed form (see the Associahedron and Hypersimplex sections).*)

(* ::Input:: *)
(*checkInstance[label_String, pts_List, expectedF_List, expectedVol_ : None] := Module[{f, vol, fPass, volPass},
  f = FVector[pts];
  vol = PolytopeVolume[pts];
  fPass = (f === expectedF);
  Print[label, "   vertices=", Length[pts], "   f-vector=", f, " (expected ", expectedF, ")", "   volume=", vol];
  Print["   f-vector match: ", fPass];
  AppendTo[$allResults, {label <> " f-vector", fPass}];
  If[expectedVol =!= None,
    volPass = (Simplify[vol - expectedVol] === 0);
    Print["   volume match (expected ", expectedVol, "): ", volPass];
    AppendTo[$allResults, {label <> " volume", volPass}];
  ];
];*)

(* ::Section:: *)
(*Simplex*)

(* ::Text:: *)
(*S_n^(0), reduced chart, d = n-1. Expected f-vectors and volumes from docs/catalog/simplex.md and verification/results/simplex.md.*)

(* ::Input:: *)
(*checkInstance["Simplex d=1", SimplexVertices[1], {2}, 1];*)
(*checkInstance["Simplex d=2", SimplexVertices[2], {3, 3}, 1/2];*)
(*checkInstance["Simplex d=3", SimplexVertices[3], {4, 6, 4}, 1/6];*)

(* ::Text:: *)
(*Canonical form check (d=3): a single simplex is its own only triangulation, so this is the direct bracket formula. Compare against docs/catalog/simplex.md's closed form 1/(y1 y2 y3 y4), y4 = 1-y1-y2-y3, up to overall orientation sign (the canonical form is only defined up to the choice of orientation of X\[GreaterEqual]0 -- see docs/theory/positive-geometries.md).*)

(* ::Input:: *)
(*y = {y1, y2, y3};*)
(*phi = CanonicalFormDensity[SimplexVertices[3], y];*)
(*known = 1/(y1 y2 y3 (1 - y1 - y2 - y3));*)
(*cfPass = (Simplify[phi - known] === 0 || Simplify[phi + known] === 0);*)
(*Print["Simplex d=3 canonical form density: ", phi];*)
(*Print["matches known closed form up to sign: ", cfPass];*)
(*AppendTo[$allResults, {"Simplex d=3 canonical form (up to sign)", cfPass}];*)

(* ::Section:: *)
(*Hypercube*)

(* ::Text:: *)
(*K_d^(0) = [0,1]^d. Expected values from docs/catalog/hypercube.md and verification/results/hypercube.md.*)

(* ::Input:: *)
(*checkInstance["Hypercube d=1", HypercubeVertices[1], {2}, 1];*)
(*checkInstance["Hypercube d=2", HypercubeVertices[2], {4, 4}, 1];*)
(*checkInstance["Hypercube d=3", HypercubeVertices[3], {8, 12, 6}, 1];*)

(* ::Text:: *)
(*Canonical form check (d=3), via PullingTriangulation (this package's own triangulation code, independent of TOPCOM). Compare against docs/catalog/hypercube.md's closed form 1/(y1(y1-1) y2(y2-1) y3(y3-1)), up to overall sign.*)

(* ::Input:: *)
(*phiCube = CanonicalFormDensity[HypercubeVertices[3], y];*)
(*knownCube = 1/Times @@ (#(# - 1) & /@ y);*)
(*cfCubePass = (Simplify[phiCube - knownCube] === 0 || Simplify[phiCube + knownCube] === 0);*)
(*Print["Hypercube d=3 canonical form density: ", phiCube];*)
(*Print["matches known closed form up to sign: ", cfCubePass];*)
(*AppendTo[$allResults, {"Hypercube d=3 canonical form (up to sign)", cfCubePass}];*)

(* ::Text:: *)
(*Dual check (d=3): the polar of the CENTERED cube should be combinatorially the octahedron (cross-polytope) -- see docs/catalog/hypercube.md.*)

(* ::Input:: *)
(*centeredCube = HypercubeVertices[3] - 1/2;*)
(*dualVerts = PolarDual[centeredCube];*)
(*dualFVector = FVector[dualVerts];*)
(*dualPass = (dualFVector === {6, 12, 8});*)
(*Print["Hypercube d=3 dual vertices: ", dualVerts];*)
(*Print["dual f-vector: ", dualFVector, "   matches octahedron {6,12,8}: ", dualPass];*)
(*AppendTo[$allResults, {"Hypercube d=3 dual is the octahedron", dualPass}];*)

(* ::Section:: *)
(*Cross-polytope*)

(* ::Text:: *)
(*X_d = conv{+-e_i}. Expected values from docs/catalog/cross-polytope.md and this project's Sage cross-check.*)

(* ::Input:: *)
(*checkInstance["Cross-polytope d=1", CrossPolytopeVertices[1], {2}, 2];*)
(*checkInstance["Cross-polytope d=2", CrossPolytopeVertices[2], {4, 4}, 2];*)
(*checkInstance["Cross-polytope d=3", CrossPolytopeVertices[3], {6, 12, 8}, 4/3];*)

(* ::Section:: *)
(*Permutohedron*)

(* ::Text:: *)
(*\[CapitalPi]_(n-1) = conv{permutations of (1,...,n)}, dimension n-1, living in a hyperplane of R^n \[Dash] PolytopeVolume gives the INDUCED (intrinsic) Euclidean volume, matching Sage's volume(measure->'induced'), not the (zero) ambient R^n volume. If your Mathematica version returns 0 here instead, your Volume/RegionMeasure isn't auto-detecting the induced measure for this region and the comparison will correctly report a mismatch -- that's a real difference worth knowing about, not a bug in this notebook.*)

(* ::Input:: *)
(*checkInstance["Permutohedron n=2", PermutohedronVertices[2], {2}, Sqrt[2]];*)
(*checkInstance["Permutohedron n=3", PermutohedronVertices[3], {6, 6}, 3 Sqrt[3]];*)
(*checkInstance["Permutohedron n=4", PermutohedronVertices[4], {24, 36, 14}, 32];*)

(* ::Section:: *)
(*Associahedron*)

(* ::Text:: *)
(*K_L, Loday's coordinates, dimension L-2, also living in a hyperplane of R^(L-1) (induced volume again). L=4's volume isn't a clean closed form this notebook asserts against -- computed and printed only (expectedVol left as None); the independently computed Sage reference value is \[TildeTilde]6.0621778.*)

(* ::Input:: *)
(*checkInstance["Associahedron L=3", AssociahedronVertices[3], {2}, Sqrt[2]];*)
(*checkInstance["Associahedron L=4", AssociahedronVertices[4], {5, 5}];*)
(*checkInstance["Associahedron L=5", AssociahedronVertices[5], {14, 21, 9}, 142/3];*)

(* ::Section:: *)
(*Hypersimplex*)

(* ::Text:: *)
(*\[CapitalDelta](2,n) slice (matching docs/catalog/hypersimplex.md's "Embeddings by dimension"), dimension n-1. n=5,6's induced volumes aren't clean closed forms asserted here -- Sage reference values \[TildeTilde]1.0248645 and \[TildeTilde]0.5307228 respectively.*)

(* ::Input:: *)
(*checkInstance["Hypersimplex \[CapitalDelta](2,4)", HypersimplexVertices[2, 4], {6, 12, 8}, 4/3];*)
(*checkInstance["Hypersimplex \[CapitalDelta](2,5)", HypersimplexVertices[2, 5], {10, 30, 30, 10}];*)
(*checkInstance["Hypersimplex \[CapitalDelta](2,6)", HypersimplexVertices[2, 6], {15, 60, 80, 45, 12}];*)

(* ::Section:: *)
(*Cyclic polytope*)

(* ::Text:: *)
(*C(n,d), n=d+3 slice (matching docs/catalog/cyclic-polytope.md), integer moment-curve parameters t=1,...,n.*)

(* ::Input:: *)
(*checkInstance["Cyclic polytope C(5,2)", CyclicPolytopeVertices[5, 2], {5, 5}, 10];*)
(*checkInstance["Cyclic polytope C(6,3)", CyclicPolytopeVertices[6, 3], {6, 12, 8}, 70];*)
(*checkInstance["Cyclic polytope C(7,4)", CyclicPolytopeVertices[7, 4], {7, 21, 28, 14}, 1512];*)

(* ::Section:: *)
(*Summary*)

(* ::Text:: *)
(*Run this cell last, after every section above has been evaluated (so $allResults is fully populated).*)

(* ::Input:: *)
(*Print["=== SUMMARY: ", Length[$allResults], " checks ==="];*)
(*Print[Column[(#[[1]] <> ": " <> ToString[#[[2]]]) & /@ $allResults]];*)
(*Print["ALL PASSED: ", And @@ (Last /@ $allResults)];*)
