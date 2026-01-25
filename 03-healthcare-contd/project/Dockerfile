FROM python:3.12-slim

WORKDIR /app

# Install system dependencies (sqlite3 for db access, curl+nodejs for Claude Code CLI)
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl sqlite3 && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install uv for fast, deterministic Python dependency management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

COPY requirements.txt .
RUN uv pip install --system -r requirements.txt

COPY . .

RUN mkdir -p /app/data

EXPOSE 8000

CMD ["chainlit", "run", "app.py", "--host", "0.0.0.0", "--port", "8000"]
