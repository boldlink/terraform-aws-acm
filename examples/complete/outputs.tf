output "record_fqdn" {
  description = "FQDN built using the zone domain and name."
  value       = module.acm_complete.record_fqdn
}
