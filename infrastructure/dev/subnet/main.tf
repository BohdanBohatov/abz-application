module "vpc_subnet" {
  source                          = "../../modules/subnet"
  env                             = "dev"
  vpc_id                          = data.terraform_remote_state.vpc.outputs.vpc_id
  availability_zone_1             = "eu-west-1a"
  availability_zone_2             = "eu-west-1b"
  cidr_block_private_subnet_1     = "10.0.0.0/22"
  cidr_block_private_subnet_2     = "10.0.8.0/22"
  cidr_block_public_subnet_1      = "10.0.4.0/22"
  cidr_block_public_subnet_2      = "10.0.12.0/22"
  cidr_block_private_nat_subnet_1 = "10.0.16.0/22"
  cidr_block_private_nat_subnet_2 = "10.0.20.0/22"
  vpc_cidr_block                  = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
}
