module "wp_alb_security_group" {
  source = "../../../modules/security_groups/wp_alb_security_group"

  env               = "dev"
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_egress_ipv4  = "0.0.0.0/0"
  cidr_ingress_ipv4 = "0.0.0.0/0"
}