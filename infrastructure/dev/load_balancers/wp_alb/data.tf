data "terraform_remote_state" "wp_alb_sg" {
  backend = "local"
  config = {
    path = "../../security_groups/wp_alb_security_group/terraform.tfstate"
  }
}

data "terraform_remote_state" "subnets" {
  backend = "local"
  config = {
    path = "../../subnet/terraform.tfstate"
  }
}

data "terraform_remote_state" "wp_target_group" {
  backend = "local"
  config = {
    path = "../../target_groups/wp_tg/terraform.tfstate"
  }
}

data "terraform_remote_state" "route53" {
  backend = "local"
  config = {
    path = "../../route_53/alphabetagamazeta/terraform.tfstate"
  }
}