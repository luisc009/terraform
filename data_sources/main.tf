provider "local" {}


# https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file
data "local_file" "hello_world" {
  filename = "hello_world.txt"
}

output "content" {
  value = data.local_file.hello_world.content
}
