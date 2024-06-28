output "record_name" {
  description = "The name of the DNS record set."
  value       = google_dns_record_set.dns_record.name
}

output "record_type" {
  description = "The type of the DNS record set."
  value       = google_dns_record_set.dns_record.type
}

output "record_ttl" {
  description = "The TTL of the DNS record set."
  value       = google_dns_record_set.dns_record.ttl
}

output "record_rrdatas" {
  description = "The resource record data values of the DNS record set."
  value       = google_dns_record_set.dns_record.rrdatas
}
