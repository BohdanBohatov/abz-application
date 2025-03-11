output "abgz_route53_zone_id" {
  description = "Route53 roze id."
  value       = module.abgz_site.route53_zone_id
}

output "tls_ssl_arn" {
  description = "TLS/SSL arn."
  value       = module.abgz_site.tls_ssl_arn
}