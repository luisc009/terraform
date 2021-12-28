output "database_config_id" {
  value = resource.local_file.database_config.id
}

output "app_config_id" {
  value = resource.local_file.app_config.id
}
