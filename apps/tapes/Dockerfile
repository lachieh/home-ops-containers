# syntax=docker/dockerfile:1
FROM golang:1.26-bookworm AS builder

ARG VERSION=v0.34.0
ARG SOURCE=https://github.com/papercomputeco/tapes

WORKDIR /src

RUN curl -fsSL "${SOURCE}/archive/refs/tags/${VERSION}.tar.gz" -o source.tar.gz \
    && tar -xzf source.tar.gz --strip-components=1 \
    && rm source.tar.gz

RUN go mod download
RUN CGO_ENABLED=0 GOEXPERIMENT="jsonv2" go build \
    -ldflags="-s -w -extldflags '-static'" \
    -o /bin/tapes \
    ./cli/tapes

FROM alpine:3.20

RUN apk add --no-cache ca-certificates \
    && addgroup -g 1000 tapes \
    && adduser -u 1000 -G tapes -s /bin/sh -D tapes

WORKDIR /app
COPY --from=builder /bin/tapes /app/tapes

USER tapes
EXPOSE 8080 8081 8082
ENTRYPOINT ["/app/tapes"]
