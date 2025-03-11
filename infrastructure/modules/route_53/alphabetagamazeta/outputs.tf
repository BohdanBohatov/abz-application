output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "tls_ssl_arn" {
  value = aws_acm_certificate.abgz_certificate.arn
}