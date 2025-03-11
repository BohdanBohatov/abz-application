module "wordpress_application_lb" {
  source = "../../../modules/load_balancers/wp_alb"

  env                = "dev"
  subnets_ids        = [data.terraform_remote_state.subnets.outputs.public_subnet_1_id, data.terraform_remote_state.subnets.outputs.public_subnet_2_id]
  target_group_arn   = data.terraform_remote_state.wp_target_group.outputs.wordpress_tg_arn
  security_group_ids = [data.terraform_remote_state.wp_alb_sg.outputs.wp_alb_security_group_id]
  route53_zone_id    = data.terraform_remote_state.route53.outputs.abgz_route53_zone_id
  certificate_arn    = data.terraform_remote_state.route53.outputs.tls_ssl_arn
}