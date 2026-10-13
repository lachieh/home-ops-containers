# Containers

An opinionated collection of container images for homelab applications.

## Available Images

| Container | Description |
|-----------|-------------|
| `ghcr.io/lachieh/odysseus` | Self-hosted AI workspace |
| `ghcr.io/lachieh/mem0-api` | Mem0 self-hosted memory API |
| `ghcr.io/lachieh/mem0-dashboard` | Mem0 self-hosted dashboard |
| `ghcr.io/lachieh/tapes` | Transparent agent telemetry server |
| `ghcr.io/lachieh/t3code` | T3 Code server, rebuilt daily from the newest nightly |

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