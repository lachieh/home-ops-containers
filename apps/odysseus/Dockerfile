FROM python:3.12-slim@sha256:d764629ce0ddd8c71fd371e9901efb324a95789d2315a47db7e4d27e78f1b0e9

ARG TARGETPLATFORM
ARG VERSION=main
ARG SOURCE=https://github.com/pewdiepie-archdaemon/odysseus

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    curl \
    git \
    nodejs \
    npm \
    tmux \
    openssh-client \
    gosu \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN case "${TARGETPLATFORM}" in \
    linux/arm64) \
        curl -L "${SOURCE}/archive/${VERSION}.tar.gz" -o - | tar xz --strip-components=1 ;; \
    *) \
        curl -L "${SOURCE}/archive/${VERSION}.tar.gz" -o - | tar xz --strip-components=1 ;; \
    esac

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p data logs services/cache/search

ENTRYPOINT ["/app/docker/entrypoint.sh"]
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7000"]