resource "aws_route53_zone" "main" {
  name = "alphabetagamazeta.site"

  tags = {
    CreatedBy   = "Terraform"
    Name        = "${var.env}-route53"
    Environment = "${var.env}"
  }
}


resource "aws_acm_certificate" "abgz_certificate" {
  domain_name       = "alphabetagamazeta.site"
  validation_method = "DNS"

  tags = {
    CreatedBy   = "Terraform"
    Name        = "${var.env}-certificate"
    Environment = "${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "certificate_route" {
  for_each = {
    for dvo in aws_acm_certificate.abgz_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}