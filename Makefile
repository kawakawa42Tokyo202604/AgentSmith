.PHONY: install run debug sandbox clean fclean lint lint-strict test

UV ?= uv
TEST_PYTHON ?= 3.10
TEST_ARGS ?=

install:
	uv sync

run:
	uv run python -m agent_mbpp --help

debug:
	uv run python -m pdb -m agent_mbpp --help

sandbox:
	uv run sandbox

clean:
	find . -type d -name "__pycache__" -not -path "./.venv/*" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	rm -rf .mypy_cache .pytest_cache .coverage htmlcov

fclean: clean
	rm -rf .venv

lint:
	uv run flake8 --exclude=.venv .
	uv run mypy --exclude .venv --exclude models.py --explicit-package-bases \
		--warn-return-any --warn-unused-ignores --ignore-missing-imports \
		--disallow-untyped-defs --check-untyped-defs .

lint-strict:
	uv run flake8 --exclude=.venv .
	uv run mypy --exclude .venv --exclude models.py --strict .

test:
	$(UV) run --no-project --python $(TEST_PYTHON) \
		--with-requirements requirements-test.txt \
		python -m pytest tests -v $(TEST_ARGS)
