module "wordpress_target_group" {
  source = "../../../modules/target_groups/wp_tg"

  env                              = "dev"
  vpc_id                           = data.terraform_remote_state.vpc.outputs.vpc_id
  health_interval                  = 30
  health_timeout                   = 15
  healthy_threshold                = 3
  unhealthy_threshold              = 3
  expected_healthy_server_response = "200"
  target_group_port                = 80
  instance_port                    = 80
  instance_id                      = data.terraform_remote_state.ec2_instance.outputs.instance_id
}