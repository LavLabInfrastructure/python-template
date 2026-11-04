.DEFAULT_GOAL := help

.PHONY: help check test cov lint format fix types docs serve-docs build clean install pre-commit docker-dev docker-prod

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install Hatch and create development environments
	python -m pip install --upgrade hatch
	hatch env create test lint types docs

check: ## Run all pre-commit checks (format, lint, types, tests, docs, package build)
	hatch run lint:format-check
	hatch run lint:check
	hatch run types:check
	hatch run test:cov
	hatch run docs:build-docs
	hatch build

test: ## Run tests
	hatch run test:test

cov: ## Run tests with coverage report
	hatch run test:cov

lint: ## Run Ruff linter
	hatch run lint:check

format: ## Format code with Ruff
	hatch run lint:format

fix: ## Auto-fix lint issues and format
	hatch run lint:all

types: ## Run mypy type checking
	hatch run types:check

docs: ## Build documentation with Zensical
	hatch run docs:build-docs

serve-docs: ## Serve documentation locally with Zensical
	hatch run docs:serve-docs

build: ## Build wheel and sdist
	hatch build

clean: ## Remove build artifacts and caches
	rm -rf dist/ build/ site/ htmlcov/
	rm -f coverage.xml .coverage
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .pytest_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .mypy_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .ruff_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name '*.egg-info' -exec rm -rf {} + 2>/dev/null || true

pre-commit: ## Install and run pre-commit hooks
	pre-commit install
	pre-commit run --all-files

docker-dev: ## Build and run dev Docker image
	docker build --target dev -t myapp:dev .

docker-prod: ## Build production Docker image
	docker build --target prod -t myapp:prod .
