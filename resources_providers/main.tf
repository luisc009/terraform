provider "local" {}


# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "hello_world" {
  filename = "hello_world.txt"
  content  = "Hello World"
}
