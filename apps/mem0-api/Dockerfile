FROM python:3.12-slim

ARG VERSION=50bdaaea0c02744720ed374d88584fd01494eeb7
ARG SOURCE=https://github.com/mem0ai/mem0

RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN curl -fsSL "${SOURCE}/archive/${VERSION}.tar.gz" | tar xz --strip-components=1

WORKDIR /app/server
RUN pip install --no-cache-dir -r requirements.txt \
    && mkdir -p /app/history

EXPOSE 8000
ENV PYTHONUNBUFFERED=1
CMD ["sh", "-c", "alembic upgrade head && exec uvicorn main:app --host 0.0.0.0 --port 8000"]
