module "ec2_instance" {
  source = "../../modules/ec2"

  instance_ami         = "ami-01abc311118516654"
  instance_type        = "t2.micro"
  env                  = "dev"
  subnet_id            = data.terraform_remote_state.subnets.outputs.private_nat_subnet_1_id
  security_group       = data.terraform_remote_state.ec2_security_group.outputs.security_group_id
  key_name             = data.terraform_remote_state.key_pair.outputs.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = data.terraform_remote_state.ec2_role.outputs.ec2_role_name
}
