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
