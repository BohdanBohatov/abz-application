data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../../vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "mysql_security_group" {
  backend = "local"
  config = {
    path = "../../security_groups/mysql_security_group/terraform.tfstate"
  }
}

data "terraform_remote_state" "subnets" {
  backend = "local"
  config = {
    path = "../../subnet/terraform.tfstate"
  }
}
