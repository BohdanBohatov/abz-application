data "terraform_remote_state" "codedeploy_role" {
  backend = "local"
  config = {
    path = "../iam_roles/codedeploy_role/terraform.tfstate"
  }
}