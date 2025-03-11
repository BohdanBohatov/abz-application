module "github_for_codedeploy_role" {
  source                   = "../../../modules/iam_roles/github_role"
  env                      = "dev"
  s3_codedeploy_bucket_arn = data.terraform_remote_state.s3_codedeploy_bucket.outputs.s3_codedeploy_bucket_arn
  accountId                = "052195330873"
}