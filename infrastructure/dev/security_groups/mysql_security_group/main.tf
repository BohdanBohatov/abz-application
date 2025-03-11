module "mysql_security_group" {
  source = "../../../modules/security_groups/mysql_security_group"

  env      = "dev"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
}