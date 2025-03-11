resource "aws_iam_role" "codedeploy_iam_role" {
  name               = "${var.env}-codedeploy-role"
  assume_role_policy = data.aws_iam_policy_document.assume_codedeploy_role.json

  tags = {
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy_iam_role.name
}

data "aws_iam_policy_document" "assume_codedeploy_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}