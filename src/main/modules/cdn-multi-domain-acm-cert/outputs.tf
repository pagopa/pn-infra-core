output "certificate_arn" {
  value = (length(aws_acm_certificate_validation.main) > 0 ? aws_acm_certificate_validation.main[0].certificate_arn : aws_acm_certificate.main.arn)
  description = "ARN of the certificate. If no external domains are present (i.e. auto validation is executed), returns the validated ARN; otherwise, returns the created ARN (certificate remains pending validation for external domains)."
}


output "certificate_principal_domain" {
  value       = aws_acm_certificate.main.domain_name
  description = "Main certificate domain."
}

output "cert_domains" {
  value       = concat(
    [aws_acm_certificate.main.domain_name],
    [for domain in tolist(aws_acm_certificate.main.subject_alternative_names): domain if domain != aws_acm_certificate.main.domain_name]
  )
  description = "List of all domains included in the certificate, with the primary domain first."
}

output "certificate_validation_records" {
  value = {
    for domain, record in aws_route53_record.validation : domain => {
      name    = record.name
      records = record.records
      type    = record.type
      zone_id = record.zone_id
    }
  }
  description = "Details of internal validation records."
}

output "domain_validation_options" {
  value       = aws_acm_certificate.main.domain_validation_options
  description = "Domain validation options."
  sensitive   = true
}

output "external_zones_validation_records" {
  value = {
    for dvo in aws_acm_certificate.main.domain_validation_options :
    trimsuffix(dvo.domain_name, ".") => {
      name    = dvo.resource_record_name,
      type    = dvo.resource_record_type,
      records = [ dvo.resource_record_value ],
      zone    = local.external_domains[trimsuffix(dvo.domain_name, ".")]
    }
    if contains(keys(local.external_domains), trimsuffix(dvo.domain_name, "."))
  }
  description = "Details of the DNS validation records for domains matching allowed_external_zones (to be created manually in the external account)."
}
