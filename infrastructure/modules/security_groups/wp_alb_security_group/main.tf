resource "aws_security_group" "wordpress_application_lb" {
  name        = "${var.env}-wordpress_application_lb"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = var.vpc_id

  tags = {
    "Name"        = "${var.env}-allow-http-s-traffic"
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

#Egres rules
resource "aws_vpc_security_group_egress_rule" "outbound_traffic" {
  security_group_id = aws_security_group.wordpress_application_lb.id
  cidr_ipv4         = var.cidr_egress_ipv4
  ip_protocol       = "-1"
  tags = {
    "Name"        = "${var.env}-allow-all-outbound-tr"
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

#Ingres rules
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  description       = "Allow http from anywhere."
  security_group_id = aws_security_group.wordpress_application_lb.id
  cidr_ipv4         = var.cidr_ingress_ipv4
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  tags = {
    "Name"        = "${var.env}-allow-http-sg"
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  description       = "Allow https from anywhere."
  security_group_id = aws_security_group.wordpress_application_lb.id
  cidr_ipv4         = var.cidr_ingress_ipv4
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  tags = {
    "Name"        = "${var.env}-allow-https-sg"
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}