data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../../vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "ec2_instance" {
  backend = "local"
  config = {
    path = "../../ec2/terraform.tfstate"
  }
}