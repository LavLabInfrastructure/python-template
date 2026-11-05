# Copilot Instructions

## Python Practices

- Support Python 3.11 and newer. Keep syntax, standard-library APIs, and dependency versions compatible with the declared minimum in `pyproject.toml`.
- Prefer clear, small functions with explicit type annotations. Keep business logic in importable modules under `src/python_template/`; keep `cli.py` as a thin interface.
- Follow the existing Ruff configuration (88-character lines, Ruff formatting and linting) and Sphinx-style docstrings. Avoid unnecessary abstractions and dependencies.
- Use the standard library when it is sufficient; handle errors explicitly, avoid mutable default arguments, and use context managers for resources.
- Add or update focused pytest tests for behavior changes. Tests should call library code directly, not the CLI wrapper.

## Preferred Packages

Prefer these established project tools and libraries when a dependency is appropriate; check `pyproject.toml` first and avoid adding overlapping packages.

| Purpose | Preferred choice |
| --- | --- |
| Project metadata, environments, tasks, and builds | Hatch / Hatchling |
| Linting and formatting | Ruff |
| Static type checking | mypy |
| Tests and coverage | pytest, pytest-cov, coverage.py |
| YAML | PyYAML |
| HTTP clients | `httpx` for new synchronous or asynchronous clients; use the standard library for simple cases |
| Data validation and settings | Pydantic when runtime schema validation is needed; use dataclasses for simple internal data structures |
| Command-line interfaces | `argparse` for simple commands; Typer when a richer typed CLI is justified |
| Documentation | Zensical with its modern theme |
| Numerical arrays and computation | NumPy; SciPy for established scientific algorithms |
| Tabular and columnar data | PyArrow for Arrow/Parquet interoperability; Polars for fast DataFrame workloads; pandas when ecosystem compatibility calls for it |
| Large image I/O and processing | pyvips for memory-efficient large-image pipelines |
| Scientific image processing | scikit-image (`skimage`) or scipy for image analysis and classical algorithms |
| Medical imaging | MONAI for medical-imaging workflows built on PyTorch |
| Machine learning / deep learning | MONAI |

Choose dependencies based on the use case rather than adding every preferred package by default. Declare runtime dependencies separately from Hatch development-environment dependencies.

## Avoid Unless Explicitly Requested

- Avoid OpenCV (`opencv-python` / `cv2`) by default; prefer pyvips, scikit-image, or focused libraries that better fit the image-processing task.
- Avoid TensorFlow by default; prefer PyTorch and compatible tools such as MONAI for deep-learning workflows.
- Do not add a disfavored package just because it is common. Explain the tradeoff and ask before introducing one when there is no suitable preferred alternative.

## Git Branching

For Git projects whose `origin` is a GitHub organization, create a new branch with a concise, descriptive name before making changes. Check the current branch and worktree first, and preserve any existing uncommitted user changes; do not switch branches if doing so could disrupt them.

## Development Workflow

1. Inspect the existing module, its callers, and tests before changing architecture or public APIs.
2. Implement behavior in `src/python_template/`, keeping the command-line layer thin.
3. Add or update tests in `tests/` and update relevant documentation when behavior or usage changes.
4. Run `hatch run check` before considering the change complete. It runs formatting checks, Ruff, mypy, tests with coverage, the documentation build, and package builds.
5. For focused iteration, use the task scripts in `pyproject.toml` (for example, `hatch run test:test`, `hatch run lint:check`, or `hatch run types:check`).
6. Review the final diff for compatibility with Python 3.11+, unintended generated files, and unrelated changes.

## ZeroC Ice on Glencoe

When a project needs ZeroC Ice, use the [Glencoe ZeroC Ice wheel installer gist](https://gist.github.com/barrettMCW/5e90f30b19a25864049a0237d55a4e92) to select and install the wheel for the active Python version and operating system. The script installs into the environment selected by `python3`; activate the intended environment first. Its current cases cover macOS and Linux with Python 3.8–3.12 only, so do not assume a compatible wheel exists for Python 3.13+ or another platform; check the gist for updates. If the current version is unsupported, tell the user to use a different python version. Review the script before running it because it installs a package from a remote wheel URL. Do not assume a source build or ordinary public PyPI install is appropriate, and do not put private package-index credentials in source files.
