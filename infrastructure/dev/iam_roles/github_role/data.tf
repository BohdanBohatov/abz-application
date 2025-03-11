data "terraform_remote_state" "s3_codedeploy_bucket" {
  backend = "local"
  config = {
    path = "../../s3_buckets/s3_codedeploy_bucket/terraform.tfstate"
  }
}