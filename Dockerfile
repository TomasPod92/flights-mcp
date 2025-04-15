FROM python:3.12-slim-bookworm

WORKDIR /app

# Nainstaluj základní nástroje
RUN apt-get update && apt-get install -y build-essential && \
    pip install --upgrade pip

# Zkopíruj závislosti a projekt
COPY pyproject.toml poetry.lock ./
RUN pip install poetry && poetry config virtualenvs.create false && poetry install --no-root

COPY src/ ./src

# Port pro Render
ENV PORT=10000

# Start FastAPI přes uvicorn
CMD ["python", "-m", "uvicorn", "flights.api:app", "--host", "0.0.0.0", "--port", "10000"]
