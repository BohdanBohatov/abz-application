resource "aws_iam_role" "github_for_codedeploy_role" {
  name = "${var.env}_github_for_codedeploy_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole"]
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      },
      {
        Action = ["sts:AssumeRole"]
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.accountId}:root"
        }
      }
    ]
  })

  tags = {
    "ManagedBy"   = "Terraform",
    "Environment" = "${var.env}"
  }
}

data "aws_iam_policy_document" "github_for_codedeploy_document" {
  statement {
    effect = "Allow"
    actions = ["codedeploy:Get*",
      "codedeploy:Batch*",
      "codedeploy:CreateDeployment",
      "codedeploy:RegisterApplicationRevision",
    "codedeploy:List*"]
    resources = ["arn:aws:codedeploy:*:${var.accountId}:*", ]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:putObject"]
    resources = ["${var.s3_codedeploy_bucket_arn}/*"]
  }

}

resource "aws_iam_policy" "github_for_codedeploy_policy" {
  name        = "${var.env}-github-codedeploy-policy"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.github_for_codedeploy_document.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.github_for_codedeploy_role.name
  policy_arn = aws_iam_policy.github_for_codedeploy_policy.arn
}
