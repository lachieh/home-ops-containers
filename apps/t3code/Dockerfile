# syntax=docker/dockerfile:1
FROM debian:bookworm-slim AS download

ARG VERSION
ARG TARGETARCH
ARG SOURCE=https://github.com/pingdotgg/t3code

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /download
RUN test -n "${VERSION}" || { echo "VERSION build arg is required" >&2; exit 1; } \
    && case "${TARGETARCH}" in amd64) arch=x64 ;; arm64) arch=arm64 ;; *) echo "unsupported arch ${TARGETARCH}" >&2; exit 1 ;; esac \
    && archive="t3-${VERSION}-linux-${arch}.tar.gz" \
    && curl -fsSLO "${SOURCE}/releases/download/v${VERSION}/${archive}" \
    && curl -fsSLO "${SOURCE}/releases/download/v${VERSION}/SHA256SUMS" \
    && grep " \*\{0,1\}${archive}\$" SHA256SUMS | sha256sum -c - \
    && mkdir /opt/t3 \
    && tar -xzf "${archive}" -C /opt/t3 --strip-components=1

FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates git libatomic1 openssh-client tini \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g 1000 t3 \
    && useradd -u 1000 -g t3 -m -d /home/t3 -s /bin/sh t3

COPY --from=download /opt/t3 /opt/t3
RUN ln -s /opt/t3/t3 /usr/local/bin/t3 && t3 --version \
    && install -d -o t3 -g t3 /data

ENV T3CODE_HOME=/data \
    T3CODE_HOST=0.0.0.0 \
    T3CODE_PORT=3773 \
    T3CODE_NO_BROWSER=1

USER t3
WORKDIR /home/t3
EXPOSE 3773
ENTRYPOINT ["/usr/bin/tini", "--", "t3"]
CMD ["serve"]
