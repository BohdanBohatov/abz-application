resource "aws_codedeploy_app" "wordpress_codedeploy_app" {
  compute_platform = "Server"
  name             = "${var.env}-wordpres-application"

  tags = {
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

resource "aws_codedeploy_deployment_group" "wordpress_deployment_group" {
  app_name               = aws_codedeploy_app.wordpress_codedeploy_app.name
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  deployment_group_name  = "${var.env}-wordpress-deployment-group"
  service_role_arn       = var.codedeploy_iam_role

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "${var.env}-WordPress-instance"
    }

    ec2_tag_filter {
      key   = "Environment"
      type  = "KEY_AND_VALUE"
      value = var.env
    }

    ec2_tag_filter {
      key   = "Type"
      type  = "KEY_AND_VALUE"
      value = "${var.env}-wordpress"
    }
  }


  outdated_instances_strategy = "UPDATE"

  tags = {
    "Name"        = "${var.env}-wordpress-deployment-group"
    "Environment" = var.env
    "ManagedBy"   = "Terraform"
  }

}
