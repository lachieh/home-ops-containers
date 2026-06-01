// renovate: datasource=github-releases depName=pewdiepie-archdaemon/odysseus versioning=docker

target "docker-metadata-action" {}

variable "APP" {
  default = "odysseus"
}

variable "SOURCE" {
  default = "https://github.com/pewdiepie-archdaemon/odysseus"
}

group "default" {
  targets = ["image-local", "image-all"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  context = "."
  dockerfile = "Dockerfile"
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
  tags = ["${APP}:rolling"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}