resource "aws_security_group" "mysql_sg" {
  name        = "${var.env}-allow-mysql-sg"
  description = "MySql security group"
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.env}-allow-mysql-in-vpc-sg"
  }
}

#Egres rules
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic" {
  security_group_id = aws_security_group.mysql_sg.id
  cidr_ipv4         = var.vpc_cidr
  ip_protocol       = "-1"
  tags = {
    "Name" = "${var.env}-allow-all-outbound"
  }
}


#Ingres rules
resource "aws_vpc_security_group_ingress_rule" "allow_local_mysql_ipv4" {
  description       = "Allow MySql port in VPC."
  security_group_id = aws_security_group.mysql_sg.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
  tags = {
    "Name" = "${var.env}-allow-mysql-sg"
  }
}