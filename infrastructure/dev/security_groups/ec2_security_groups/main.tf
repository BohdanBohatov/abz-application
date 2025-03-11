module "ec2_security_group" {
  source = "../../../modules/security_groups/ec2_security_groups"

  env                   = "dev"
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_egress_ipv4      = "0.0.0.0/0"
  cidr_ingress_ipv4     = "0.0.0.0/0"
  cidr_ingress_ssh_ipv4 = "193.238.38.96/32"
}