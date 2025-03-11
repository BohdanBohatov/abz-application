resource "aws_lb_target_group" "wp_target_group" {
  name        = "${var.env}-wordpress-tg"
  port        = var.target_group_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = var.health_interval
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = var.health_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.expected_healthy_server_response
  }

  tags = {
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}


resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.wp_target_group.arn
  target_id        = var.instance_id
  port             = var.instance_port
}
