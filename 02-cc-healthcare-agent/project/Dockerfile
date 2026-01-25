FROM python:3.12-slim

WORKDIR /app

# Install system dependencies (needed for Claude Code CLI bundled with the SDK)
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl sqlite3 && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js (required by Claude Code CLI runtime)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /app/data

EXPOSE 8000

CMD ["chainlit", "run", "app.py", "--host", "0.0.0.0", "--port", "8000"]
