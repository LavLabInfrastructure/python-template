# Python Template

[![Build](https://github.com/LavLabInfrastructure/python-template/actions/workflows/build.yml/badge.svg)](https://github.com/LavLabInfrastructure/python-template/actions/workflows/build.yml)
[![Tests](https://github.com/LavLabInfrastructure/python-template/actions/workflows/pytest.yml/badge.svg)](https://github.com/LavLabInfrastructure/python-template/actions/workflows/pytest.yml)
[![Lint](https://github.com/LavLabInfrastructure/python-template/actions/workflows/lint.yml/badge.svg)](https://github.com/LavLabInfrastructure/python-template/actions/workflows/lint.yml)
[![Docs](https://github.com/LavLabInfrastructure/python-template/actions/workflows/docs.yml/badge.svg)](https://lavlabinfrastructure.github.io/python-template/)
[![PyPI - Version](https://img.shields.io/pypi/v/python-template.svg)](https://pypi.org/project/python-template)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/python-template.svg)](https://pypi.org/project/python-template)

-----

A consistent, feature-rich template for Python projects. Use this as a starting point for new packages to get batteries-included tooling out of the box.

## What's Included

| Feature | Tool |
|---------|------|
| Build & environments | [Hatch](https://hatch.pypa.io/) |
| Linting & formatting | [Ruff](https://docs.astral.sh/ruff/) |
| Testing | [pytest](https://docs.pytest.org/) + [coverage](https://coverage.readthedocs.io/) |
| Type checking | [mypy](https://mypy.readthedocs.io/) |
| Documentation | [Zensical](https://zensical.org/) (modern theme) + [mkdocstrings](https://mkdocstrings.github.io/) |
| Containerization | Multi-stage [Dockerfile](./Dockerfile) (dev / hatch / prod) |
| CI/CD | [GitHub Actions](./.github/workflows/) with Dependabot, Python 3.11–3.15 tests, and GitHub Pages deployment |
| Dev environment | [Dev Container](./.devcontainer/) for VS Code / Codespaces |
| Git hygiene | [pre-commit](./.pre-commit-config.yaml) hooks |

## Quick Start

### Installation

```console
pip install python-template
```

### CLI

The template ships with an example CLI entry point:

```console
python-template --version
python-template example "hello world"
```

### As a Library

```python
from python_template import example

result = example("hello")
```

## Development Setup

**Prerequisites:** Python 3.11+ and [Hatch](https://hatch.pypa.io/latest/install/).

```console
git clone https://github.com/LavLabInfrastructure/python-template.git
cd python-template
python -m pip install --upgrade hatch
```

Optionally install pre-commit hooks:

```console
python -m pip install --upgrade pre-commit
pre-commit install
```

### Common Commands

Run the full check suite with `hatch run check`; it checks formatting, lint, types, tests
with coverage, documentation, and the package build. Use individual commands below for
focused work. Hatch creates each required environment on first use.

| Task | Command |
|------|---------|
| Run full check suite | `hatch run check` |
| Run tests | `hatch run test:test` |
| Tests + coverage | `hatch run test:cov` |
| Lint | `hatch run lint:check` |
| Format | `hatch run lint:format` |
| Auto-fix lint | `hatch run lint:fix` |
| Format + fix + lint | `hatch run lint:all` |
| Type check | `hatch run types:check` |
| Build docs | `hatch run docs:build-docs` |
| Serve docs | `hatch run docs:serve-docs` |
| Build wheel | `hatch build` |
| Clean build artifacts | `hatch clean` |

### Docker

```console
# Run tests via Docker
docker build --target hatch -t myapp:hatch .
docker run --rm -e HATCH_ENV=test myapp:hatch cov

# Production image (just the installed wheel)
docker build --target prod -t myapp:prod .
```

Version tags matching `v*` publish the production image to
`ghcr.io/lavinfrastructure/python-template`. To publish manually, run the **Publish Docker
image** workflow and enable its publish option. The workflow uses `GITHUB_TOKEN`; no
registry secret is needed. Set the GHCR package visibility to public if unauthenticated
pulls are desired.

Documentation is published to [GitHub Pages](https://lavlabinfrastructure.github.io/python-template/)
when changes are pushed to `main`. Enable **Settings → Pages → Build and deployment →
Source: GitHub Actions** in a repository created from this template.

## Project Structure

```text
python-template/
├── src/
│   └── python_template/        # Package source
│       ├── __init__.py          # Public API & version export
│       ├── __about__.py         # Version string
│       ├── cli.py               # CLI entry point (thin wrapper)
│       ├── example.py           # Example library module
│       └── py.typed             # PEP 561 marker
├── tests/
│   ├── conftest.py              # Shared pytest fixtures
│   └── test_example.py          # Example tests
├── docs/                        # Documentation source files
├── .devcontainer/               # Dev container config
├── .github/
│   ├── workflows/               # CI, docs deployment, and Docker publishing
│   └── dependabot.yml           # Auto-update deps + actions + Docker
├── pyproject.toml               # All project & tool configuration
├── Dockerfile                   # Multi-stage build
├── zensical.toml                # Zensical configuration
├── .pre-commit-config.yaml      # Pre-commit hooks
├── .editorconfig                # Editor consistency
└── .gitignore
```

## Design Philosophy

This template follows a **library-first** approach:

1. **All logic** lives in importable modules under `src/python_template/`.
2. **The CLI** (`cli.py`) is a thin `argparse` wrapper that delegates to library functions.
3. **Tests** call library functions directly — never through the CLI.

This keeps your code reusable whether it's called from the command line, another package, a notebook, or an API.

## Using This Template

1. Click **Use this template** on GitHub (or clone and reinitialize).
2. Rename `src/python_template/` to your package name.
3. Find-and-replace `python-template` → your project name and `python_template` → your package name.
4. Update `pyproject.toml` with your metadata (author, description, dependencies).
5. Update `LICENSE.txt` if needed.
6. Delete `example.py` and `test_example.py` once you have real code.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for development guidelines.

## License

`python-template` is distributed under the terms of the [MIT](https://spdx.org/licenses/MIT.html) license.

## Template customization checklist

When creating a repository from this template, update these references if its repository
name or owner changes:

### Replace the repository name `python-template`

- `README.md`: workflow badge URLs, PyPI badges and install/CLI examples, clone URL and
  directory, GHCR image path, project tree, template instructions, and license text.
- `CONTRIBUTING.md`: clone URL and directory.
- `docs/index.md`: title, install/CLI examples, clone URL and directory, and project tree.
- `pyproject.toml`: project distribution name, console-script name, repository URLs, and
  coverage path patterns.
- `src/python_template/cli.py`: displayed CLI program name and description.
- `zensical.toml`: documentation site name (`Python Template`) and Pages URL.

If the Python package name also changes, rename `src/python_template/` and update its
imports and references in `pyproject.toml`, `tests/`, `docs/`, and the Docker healthcheck.

### Replace the repository owner `LavLabInfrastructure`

- `README.md`: GitHub Actions badge URLs, GitHub Pages URL, clone URL, and GHCR image path
  (the GHCR owner is lowercase: `lavinfrastructure`).
- `CONTRIBUTING.md` and `docs/index.md`: clone URLs.
- `pyproject.toml`: Documentation, Issues, and Source URLs.
- `zensical.toml`: GitHub Pages URL.

The Docker publishing workflow derives the owner and repository name from
`GITHUB_REPOSITORY`, so it does not need owner-specific edits.