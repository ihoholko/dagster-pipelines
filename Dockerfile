FROM python:3.11-slim

# Copy your Dagster project. You may need to replace the filepath depending on your project structure
COPY . /

# This makes sure that logs show up immediately instead of being buffered
ENV PYTHONUNBUFFERED=1

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/


# Install dagster and any other dependencies your project requires
COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-dev


WORKDIR /deploy_k8s/

# Expose the port that your Dagster instance will run on
EXPOSE 3030