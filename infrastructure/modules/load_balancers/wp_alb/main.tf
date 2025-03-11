resource "aws_lb" "wp_application_lb" {
  name               = "${var.env}-wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets_ids
  security_groups    = var.security_group_ids
  ip_address_type    = "ipv4"

  tags = {
    name = "${var.env}-wordpress-alb"
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.wp_application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

resource "aws_lb_listener" "https_alb_listener" {
  load_balancer_arn = aws_lb.wp_application_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  tags = {
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

resource "aws_route53_record" "alb_route53_record" {
  zone_id = var.route53_zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_lb.wp_application_lb.dns_name
    zone_id                = aws_lb.wp_application_lb.zone_id
    evaluate_target_health = false
  }
}