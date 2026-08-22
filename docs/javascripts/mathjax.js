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
};

document$.subscribe(() => {
  if (window.MathJax && window.MathJax.typesetPromise) {
    MathJax.typesetPromise();
  }
});
