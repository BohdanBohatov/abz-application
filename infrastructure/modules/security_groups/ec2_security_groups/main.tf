resource "aws_security_group" "allow_ssh_ec2_sg" {
  name        = "${var.env}-allow-ec2-ssh-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.env}-allow-ssh-sg"
  }
}

#Egres rules
resource "aws_vpc_security_group_egress_rule" "name" {
  security_group_id = aws_security_group.allow_ssh_ec2_sg.id
  cidr_ipv4         = var.cidr_egress_ipv4
  ip_protocol       = "-1"
  tags = {
    "Name" = "${var.env}-allow-all-ec2-outbound"
  }
}


#Ingres rules
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  description       = "Allow SSH from anywhere."
  security_group_id = aws_security_group.allow_ssh_ec2_sg.id
  cidr_ipv4         = var.cidr_ingress_ssh_ipv4
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  tags = {
    "Name" = "${var.env}-allow-ec2-ssh-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  description       = "Allow http from anywhere."
  security_group_id = aws_security_group.allow_ssh_ec2_sg.id
  cidr_ipv4         = var.cidr_ingress_ipv4
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  tags = {
    "Name" = "${var.env}-allow-ec2-http-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  description       = "Allow https from anywhere."
  security_group_id = aws_security_group.allow_ssh_ec2_sg.id
  cidr_ipv4         = var.cidr_ingress_ipv4
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  tags = {
    "Name" = "${var.env}-allow-ec2-https-sg"
  }
}