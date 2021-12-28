output "string" {
  value = "I'm a string!"
}

output "number" {
  value = 3.1416
}

output "bool" {
  value = true
}

output "list" {
  value = ["i'm string", 3, true]
}

output "map" {
  value = {
    "1" = 1,
    "2" = 2,
  }
}

output "quoted_string" {
  value = "Hello world \nGoodbye world!"
}

output "heredoc_string" {
  value = <<EOT
        Hello 
        World
EOT
}

variable "five" {
  default = 5
}

output "five" {
  value = "the number five is ${var.five}"
}

output "another_five" {
  value = <<EOT
${var.five} is the number!
EOT
}

output "arithmetic_operators" {
  value = 5 + 5 / 2 * 5 % 5
}

output "equality" {
  value = true == false != true
}

output "comparision" {
  value = 1 > 2
}

output "min" {
  value = min(2, 3, 5)
}

output "condition" {
  value = 2 > 5 ? "dos es mayor" : "cinco es mayor"
}

output "for" {
  value = [for s in ["a", "b", "c"] : upper(s)]
}

output "list_to_map" {
  value = { for s in ["a", "b", "c"] : s => upper(s) }
}
