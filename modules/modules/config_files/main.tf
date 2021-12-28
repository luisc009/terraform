resource "local_file" "database_config" {
  filename = var.database_config_filename
  content  = <<EOT
db_host=127.0.0.1
db_user=admin
db_password=mipasswordmuydificiles
EOT
}

resource "local_file" "app_config" {
  filename = var.app_config_filename
  content  = <<EOT
url=127.0.0.1
EOT
}
