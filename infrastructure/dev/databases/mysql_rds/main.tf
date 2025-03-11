module "mysql_rds" {
  source = "../../../modules/databases/mysql_rds"

  env                 = "dev"
  db_identifier       = "mysql-database"
  engine_version      = "8.4.3"
  instance_type       = "db.t4g.micro"
  allocated_storage   = 20
  storage_type        = "gp3"
  db_name             = "wordpressdb"
  db_username         = "mysqladmin"
  security_group_id   = data.terraform_remote_state.mysql_security_group.outputs.mysql_security_group_id
  skip_final_snapshot = true
  private_subnet_ids = tolist([data.terraform_remote_state.subnets.outputs.private_subnet_1_id,
  data.terraform_remote_state.subnets.outputs.private_subnet_2_id])
}