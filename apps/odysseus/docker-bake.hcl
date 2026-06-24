variable "REGISTRY" {
  default = "ghcr.io"
}

variable "REPO_OWNER" {
  default = "lachieh"
}

variable "APP" {
  default = "odysseus"
}

variable "SOURCE" {
  default = "https://github.com/pewdiepie-archdaemon/odysseus"
}

variable "VERSION" {
  default = "dd055ee6e36581ad8c9c539e02b5b9963fbac2a1" # renovate-sha repo:https://github.com/pewdiepie-archdaemon/odysseus
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
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:rolling"]
}

target "image-all" {
  inherits = ["image"]
  context = "."
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/${REPO_OWNER}/${APP}:rolling",
    "${REGISTRY}/${REPO_OWNER}/${APP}:${DATE_TAG}"
  ]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}