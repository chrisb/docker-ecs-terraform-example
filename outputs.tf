output "alb_hostname" {
  value = aws_alb.main.dns_name
}

output "https_url" {
  value = "Visit https://${aws_route53_record.dns_record.fqdn} to validate ACM/SSL."
}

output "ssl_validation" {
  value = "Validate SSL with: openssl s_client -host ${aws_route53_record.dns_record.fqdn} -port 443"
}