resource "aws_iam_role" "ec2_role" {
  name = "${var.env}_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    "Environment" = "${var.env}"
  }
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name = "${var.env}_secrets_manager_access"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [
          "${var.mysql_secret_arn}*",
          "${var.wordpress_secret_arn}*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_role_for_db_secret_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_role_for_codeDeploy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}