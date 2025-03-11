resource "aws_instance" "word_press_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group]
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile

  #If change the instance tag's - change CodeDeploy deploy instances selection
  tags = {
    "Name" = "${var.env}-WordPress-instance"
    "Environment"  = var.env
    "Type" = "${var.env}-wordpress"
    "ManagedBy" = "Terraform"
  }
}