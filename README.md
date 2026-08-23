# Positive Geometries

Source for [tomaszlukowski.github.io/positive_geometries](https://tomaszlukowski.github.io/positive_geometries/),
a compendium of positive geometries — definitions, canonical forms, and
combinatorics, with a focus on polytopal examples.

Built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/).

## Local development

```bash
python -m venv .venv
.venv/Scripts/activate   # or source .venv/bin/activate on macOS/Linux
pip install -r requirements.txt
mkdocs serve
```

## Deployment

Pushing to `main` triggers `.github/workflows/deploy.yml`, which builds
the site with `mkdocs build --strict` and publishes it to the `gh-pages`
branch via `mkdocs gh-deploy`. That CI build is also the actual gate for
"did this change break the site" — this project has no standing local
Python/mkdocs install, so changes are typically checked by pushing and
watching the Action, not `mkdocs build --strict` run locally.

## Verification (not part of the site)

[`sagemath/`](sagemath/) independently checks the site's claims —
f-vectors, vertex embeddings, volumes, duals, canonical forms,
triangulations, secondary polytopes — computationally, via SageMath +
TOPCOM in a WSL2 environment. Not built or served by MkDocs. See its own
README for what's in there and exactly how to run it (including a full
from-scratch reinstall recipe).

Two earlier, now-removed folders (`mathematica/`, a Wolfram Language
package never actually run since no Mathematica install exists on this
machine; `verification/`, a smaller two-family pass superseded by
`sagemath/`) covered the same ground with less coverage and are gone —
see git history if either is ever needed for reference.
