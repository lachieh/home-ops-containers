variable "REGISTRY" {
  default = "ghcr.io"
}

variable "REPO_OWNER" {
  default = "lachieh"
}

variable "APP" {
  default = "t3code"
}

variable "SOURCE" {
  default = "https://github.com/pingdotgg/t3code"
}

# Resolved by the release workflow to the newest nightly release.
variable "VERSION" {
  default = ""
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
    "${REGISTRY}/${REPO_OWNER}/${APP}:${DATE_TAG}",
    "${REGISTRY}/${REPO_OWNER}/${APP}:${VERSION}"
  ]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
