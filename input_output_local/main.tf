provider "local" {}

variable "content" {
  type    = string
  default = "Hello World! from default value"
}

variable "file_name" {
  type    = string
  default = "hello_world"
}

locals {
  file_name = "${var.file_name}.txt"
}

# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "hello_world" {
  filename = local.file_name
  content  = var.content
}

output "id" {
  value = local_file.hello_world.id
}
