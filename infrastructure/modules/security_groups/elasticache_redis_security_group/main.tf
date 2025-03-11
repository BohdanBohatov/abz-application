resource "aws_security_group" "elasticache_sg" {
  name        = "${var.env}-allow-redis-inbound"
  description = "Allow redis inboud."
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.env}-allow-redis-sg"
  }
}

#Egres rules
resource "aws_vpc_security_group_egress_rule" "allow_vpc_outbound" {
  security_group_id = aws_security_group.elasticache_sg.id
  cidr_ipv4         = var.vpc_cidr_block
  ip_protocol       = "-1"
  tags = {
    "Name" = "${var.env}-allow-all-vpc-traffic-sr"
  }
}

#Ingres rules
resource "aws_vpc_security_group_ingress_rule" "allow_redis_vpc_inbound" {
  description       = "Allow inbound traffic to redis 6379 from local VPC."
  security_group_id = aws_security_group.elasticache_sg.id
  cidr_ipv4         = var.vpc_cidr_block
  from_port         = 6379
  to_port           = 6379
  ip_protocol       = "tcp"
  tags = {
    "Name" = "${var.env}-allow-redis-inbound-sr"
  }
}