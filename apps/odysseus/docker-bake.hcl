variable "APP" {
  default = "odysseus"
}

variable "SOURCE" {
  default = "https://github.com/pewdiepie-archdaemon/odysseus"
}

variable "VERSION" {
  default = "7690860ab1a7b50afd1887b5a61ca60f38961847" # renovate-sha repo:https://github.com/pewdiepie-archdaemon/odysseus
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
