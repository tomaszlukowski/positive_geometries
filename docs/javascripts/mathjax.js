window.MathJax = {
  tex: {
    inlineMath: [["\\(", "\\)"]],
    displayMath: [["\\[", "\\]"]],
    processEscapes: true,
    processEnvironments: true,
    packages: { "[+]": ["ams"] },
    macros: {
      // bracket / angle-bracket invariants used throughout canonical-form formulas,
      // e.g. \br{Z1 Z2 Z3} for <Z1 Z2 Z3>
      br: ["\\langle #1 \\rangle", 1],
      // shorthand for the canonical form itself
      Om: ["\\Omega\\!\\left(#1\\right)", 1],
      RR: "\\mathbb{R}",
      CC: "\\mathbb{C}",
      PP: "\\mathbb{P}",
      ZZ: "\\mathbb{Z}",
      conv: "\\operatorname{conv}",
      Res: "\\operatorname{Res}"
    }
  },
  options: {
    ignoreHtmlClass: ".*|",
    processHtmlClass: "arithmatex"
  }
  // startup.typeset stays at its default (true): MathJax's own automatic
  // pass is what reliably renders the very first page load, before the
  // library has necessarily finished initializing by the time our own
  // document$ hook below first fires (see typesetMath()).
};

// Material's `document$` observable fires once for the initial page and
// again on every "instant" navigation (navigation.instant is enabled in
// mkdocs.yml), which swaps in new page content without a full reload —
// content MathJax has never seen and so never auto-typesets.
//
// The two failure modes this guards against:
//   - blank on first load: document$ can fire before tex-mml-chtml.js has
//     finished loading, so `MathJax.typesetPromise` doesn't exist yet;
//     naively skipping in that case (and never retrying) leaves the page
//     untypeset until a hard refresh re-runs everything from scratch.
//   - garbled formulas after navigating: calling typesetPromise() while a
//     previous call (e.g. MathJax's own automatic startup pass) is still
//     in flight is documented to corrupt the render. Every call here is
//     chained onto MathJax.startup.promise so calls are serialized, never
//     concurrent, and typesetClear() runs first so stale "already
//     processed" state from the previous page can't cause elements to be
//     skipped or mis-rendered.
function typesetMath() {
  if (!(window.MathJax && MathJax.startup && MathJax.startup.promise)) {
    // Library not ready yet -- its own automatic startup typeset (the
    // default) will cover the very first render once it finishes.
    return;
  }
  MathJax.startup.promise = MathJax.startup.promise
    .then(() => MathJax.typesetClear())
    .then(() => MathJax.typesetPromise())
    .catch((err) => console.error("MathJax typeset failed:", err));
}

document$.subscribe(typesetMath);
