# Containers

An opinionated collection of container images for homelab applications.

## Available Images

| Container | Description |
|-----------|-------------|
| `ghcr.io/lachieh/odysseus` | Self-hosted AI workspace |

## Usage

Images are available on GitHub Container Registry:

```yaml
# Rolling latest
image: ghcr.io/lachieh/odysseus:rolling

# Date-tagged releases (vYYYY-MM-DD)
image: ghcr.io/lachieh/odysseus:v2026-06-15

# Pin to digest for immutability
image: ghcr.io/lachieh/odysseus@sha256:<digest>
```