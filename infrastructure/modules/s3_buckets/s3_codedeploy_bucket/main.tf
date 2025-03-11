resource "aws_s3_bucket" "CodeDeploy_S3_Bucket" {
  bucket = "${var.env}-codedeploy-s3-bucket"

  tags = {
    Name        = "${var.env}-codedeploy-s3-bucket"
    Environment = "${var.env}"
  }
}