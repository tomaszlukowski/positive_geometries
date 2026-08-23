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
branch via `mkdocs gh-deploy`.

## Verification (not part of the site)

Three independent folders check the site's claims — f-vectors, vertex
embeddings, volumes, duals, and canonical forms — computationally, none
built or served by MkDocs.

- [`sagemath/`](sagemath/) — one script per catalog family, all seven,
  covering the n=1,2,3 (or family-appropriate) instances; **actually run**
  in this project's WSL2 + SageMath + TOPCOM environment (42/42 checks
  pass) — see its README for exactly how to run these locally.
- [`verification/`](verification/) — an earlier, smaller pass over two
  families (simplex, hypercube), also with regular-triangulation
  enumeration and secondary polytopes via TOPCOM, which Mathematica has
  no equivalent for.
- [`mathematica/`](mathematica/) — a Wolfram Language package and a
  ready-to-run (but, absent a Mathematica install here, not yet
  actually run) verification notebook, as a second, independent tool.
