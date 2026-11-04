# Python Template

[![Build](https://github.com/LavLabInfrastructure/python-template/actions/workflows/build.yml/badge.svg)](https://github.com/LavLabInfrastructure/python-template/actions/workflows/build.yml)
[![Tests](https://github.com/LavLabInfrastructure/python-template/actions/workflows/pytest.yml/badge.svg)](https://github.com/LavLabInfrastructure/python-template/actions/workflows/pytest.yml)
[![Lint](https://github.com/LavLabInfrastructure/python-template/actions/workflows/lint.yml/badge.svg)](https://github.com/LavLabInfrastructure/python-template/actions/workflows/lint.yml)
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
| CI/CD | [GitHub Actions](./.github/workflows/) with Dependabot; Python 3.11–3.15 test matrix |
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

Run the full pre-commit suite with `make check`; it checks formatting, lint, types, tests
with coverage, documentation, and the package build. Use individual commands below for
focused work. Other tasks are also available through the provided [`Makefile`](./Makefile).

| Task | Command |
|------|---------|
| Run all pre-commit checks | `make check` |
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
| Clean artifacts | `make clean` |

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
│   ├── workflows/               # CI, tests, lint, and Docker publishing
│   └── dependabot.yml           # Auto-update deps + actions + Docker
├── pyproject.toml               # All project & tool configuration
├── Dockerfile                   # Multi-stage build
├── Makefile                     # Dev shortcuts
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