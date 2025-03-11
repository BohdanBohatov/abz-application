resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = "${var.env}-ssh-key"
  public_key = var.key_path
}