module "s3_codedeploy_bucket" {
  source = "../../../modules/s3_buckets/s3_codedeploy_bucket"

  env = "dev"
}