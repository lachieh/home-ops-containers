FROM python:3.12-slim

ARG VERSION=50bdaaea0c02744720ed374d88584fd01494eeb7
ARG SOURCE=https://github.com/mem0ai/mem0

RUN apt-get update && apt-get install -y --no-install-recommends curl libpq5 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN curl -fsSL "${SOURCE}/archive/${VERSION}.tar.gz" | tar xz --strip-components=1

# Mem0's configuration endpoint deep-merges updates into the default pgvector
# configuration. Replacing the vector-store provider must replace its config too,
# otherwise pgvector-only keys are passed to a Qdrant configuration.
RUN python -c 'from pathlib import Path; p=Path("/app/server/server_state.py"); source=p.read_text(); old="        if isinstance(value, dict) and isinstance(merged.get(key), dict):\n            merged[key] = _merge_config(merged[key], value)\n        else:\n            merged[key] = value"; new="        if (\n            key == \"vector_store\"\n            and isinstance(value, dict)\n            and value.get(\"provider\") != merged.get(key, {}).get(\"provider\")\n        ):\n            merged[key] = deepcopy(value)\n        elif isinstance(value, dict) and isinstance(merged.get(key), dict):\n            merged[key] = _merge_config(merged[key], value)\n        else:\n            merged[key] = value"; assert old in source; p.write_text(source.replace(old, new))'

WORKDIR /app/server
RUN pip install --no-cache-dir -r requirements.txt \
    && mkdir -p /app/history

EXPOSE 8000
ENV PYTHONUNBUFFERED=1
CMD ["sh", "-c", "alembic upgrade head && exec uvicorn main:app --host 0.0.0.0 --port 8000"]
