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

// The page's main content (.md-content) starts hidden -- see the CSS
// rule in extra.css -- so a visitor never sees a flash of raw,
// unrendered \(...\) source before MathJax gets to it. markMathReady()
// is what reveals it, by adding "pg-math-ready"; it's called from every
// path below, success or failure, so a broken/slow/blocked MathJax load
// never leaves the page hidden longer than the pure-CSS 2.5s fallback
// animation in extra.css (which needs no JavaScript at all, and so is
// the only thing that saves a visitor with JavaScript disabled).
function markMathReady() {
  var content = document.querySelector(".md-content");
  if (content) {
    content.classList.add("pg-math-ready");
  }
}

function hideMathContent() {
  var content = document.querySelector(".md-content");
  if (content) {
    content.classList.remove("pg-math-ready");
  }
}

// On the very first page load, MathJax.startup.promise usually doesn't
// exist yet the first time this fires (tex-mml-chtml.js hasn't finished
// loading) -- so typesetMath() below can't chain onto it directly. This
// polls for the promise to appear and reveals the page as soon as it
// resolves, rather than falling all the way back to the flat 2.5s CSS
// timeout in that case (which would otherwise make a normal slow-ish
// load look broken). Gives up after ~3s of polling; the CSS fallback
// still guarantees a reveal from there regardless.
function revealWhenMathJaxSettles(attemptsLeft) {
  if (window.MathJax && MathJax.startup && MathJax.startup.promise) {
    MathJax.startup.promise.then(markMathReady).catch(markMathReady);
  } else if (attemptsLeft > 0) {
    setTimeout(function () {
      revealWhenMathJaxSettles(attemptsLeft - 1);
    }, 30);
  }
}

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
  hideMathContent();
  if (!(window.MathJax && MathJax.startup && MathJax.startup.promise)) {
    // Library not ready yet -- its own automatic startup typeset (the
    // default) will cover the very first render once it finishes.
    revealWhenMathJaxSettles(100);
    return;
  }
  MathJax.startup.promise = MathJax.startup.promise
    .then(() => MathJax.typesetClear())
    .then(() => MathJax.typesetPromise())
    .then(markMathReady)
    .catch((err) => {
      console.error("MathJax typeset failed:", err);
      markMathReady(); // reveal anyway -- an error here shouldn't hide the page
    });
}

document$.subscribe(typesetMath);
