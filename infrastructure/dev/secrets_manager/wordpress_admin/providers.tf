# Configure the AWS Provider
provider "aws" {
  shared_config_files      = ["/home/bohdan/.aws/config"]
  shared_credentials_files = ["/home/bohdan/.aws/credentials"]
  profile                  = "learning-prod"
  region                   = "eu-west-1"
}