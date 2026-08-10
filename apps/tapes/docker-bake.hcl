variable "REGISTRY" {
  default = "ghcr.io"
}

variable "REPO_OWNER" {
  default = "lachieh"
}

variable "APP" {
  default = "tapes"
}

variable "SOURCE" {
  default = "https://github.com/papercomputeco/tapes"
}

variable "VERSION" {
  default = "v0.34.0" # renovate: datasource=github-tags depName=papercomputeco/tapes versioning=semver
}

variable "DATE_TAG" {
  default = "local"
}

target "docker-metadata-action" {}

group "default" {
  targets = ["image-local", "image-all"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  context = "."
  dockerfile = "Dockerfile"
  args = {
    VERSION = "${VERSION}"
    SOURCE  = "${SOURCE}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
    "org.opencontainers.image.version" = "${VERSION}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:rolling"]
}

target "image-all" {
  inherits = ["image"]
  tags = [
    "${REGISTRY}/${REPO_OWNER}/${APP}:rolling",
    "${REGISTRY}/${REPO_OWNER}/${APP}:${DATE_TAG}"
  ]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
