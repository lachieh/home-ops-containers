variable "APP" {
  default = "odysseus"
}

variable "SOURCE" {
  default = "https://github.com/pewdiepie-archdaemon/odysseus"
}

variable "VERSION" {
  default = "9c68ceafeb8ac9990e0c0c64a47796395299d604"
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
  tags = ["${APP}:rolling"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}