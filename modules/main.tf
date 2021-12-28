module "config_files" {
  source = "./modules/config_files"

  app_config_filename      = "myapp.txt"
  database_config_filename = "myappdb.txt"
}

output "myapp_id" {
  value = module.config_files.app_config_id
}

output "myappdb_id" {
  value = module.config_files.database_config_id
}
