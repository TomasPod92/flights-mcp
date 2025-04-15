# Use a Python image with uv pre-installed
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS uv

# Set working directory
WORKDIR /app

# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# Copy lockfile and pyproject
COPY pyproject.toml uv.lock /app/

# Install ALL dependencies (incl. dev like uvicorn!)
RUN --mount=type=cache,target=/root/.cache/uv \
    uv venv && \
    uv pip install --require-hashes -r uv.lock && \
    uv pip install .


# Copy source code and re-sync (if needed)
ADD src /app/src
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-editable

# ---------- FINAL IMAGE ----------
FROM python:3.12-slim-bookworm

WORKDIR /app

COPY --from=uv --chown=app:app /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:$PATH"

# Install uvicorn & fastapi just to be sure
RUN /app/.venv/bin/pip install --no-cache-dir uvicorn fastapi


# Optional: create non-root user
RUN adduser --disabled-password --gecos '' app && chown -R app /app
USER app

# Start server
CMD ["python", "-m", "uvicorn", "flights.api:app", "--host", "0.0.0.0", "--port", "10000"]
