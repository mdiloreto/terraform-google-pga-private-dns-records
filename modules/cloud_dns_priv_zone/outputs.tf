output "zone_name" {
  description = "The name of the DNS managed zone."
  value       = google_dns_managed_zone.dns_private_zone.name
}

output "zone_dns_name" {
  description = "The DNS name of the managed zone."
  value       = google_dns_managed_zone.dns_private_zone.dns_name
}

output "zone_id" {
  description = "The ID of the managed zone."
  value       = google_dns_managed_zone.dns_private_zone.id
}