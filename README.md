# Containers

An opinionated collection of container images for homelab applications.

## Available Images

| Container | Description |
|-----------|-------------|
| `ghcr.io/lachieh/odysseus` | Self-hosted AI workspace |

## Usage

Images are available on GitHub Container Registry:

```yaml
image: ghcr.io/lachieh/odysseus:rolling
```

Pin to digest for immutability:

```yaml
image: ghcr.io/lachieh/odysseus@sha256:<digest>
```