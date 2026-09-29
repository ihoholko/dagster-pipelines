FROM python:3.11-slim

WORKDIR /deploy_k8s/



# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/


# Install dagster and any other dependencies the project requires
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY . .


ENV PYTHONUNBUFFERED=1
ENV PATH="/deploy_k8s/.venv/bin:$PATH"

# Expose the port that your Dagster instance will run on
EXPOSE 3030