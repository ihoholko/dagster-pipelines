FROM python:3.11-slim

WORKDIR /deploy_k8s

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-dev --no-install-project

COPY . .

RUN uv sync --frozen --no-dev

ENV PYTHONUNBUFFERED=1
ENV PATH="/deploy_k8s/.venv/bin:$PATH"

EXPOSE 3030

CMD ["dagster", "api", "grpc", "-h", "0.0.0.0", "-p", "3030", "--module-name", "dagster_pipelines.definitions"]