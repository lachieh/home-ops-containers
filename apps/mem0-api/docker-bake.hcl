variable "REGISTRY" { default = "ghcr.io" }
variable "REPO_OWNER" { default = "lachieh" }
variable "APP" { default = "mem0-api" }
variable "SOURCE" { default = "https://github.com/mem0ai/mem0" }
variable "VERSION" {
  default = "50bdaaea0c02744720ed374d88584fd01494eeb7" # renovate: datasource=git-refs depName=mem0ai/mem0 versioning=git
}
variable "DATE_TAG" { default = "local" }

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
    SOURCE = "${SOURCE}"
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
  tags = [
    "${REGISTRY}/${REPO_OWNER}/${APP}:rolling",
    "${REGISTRY}/${REPO_OWNER}/${APP}:${DATE_TAG}",
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}
