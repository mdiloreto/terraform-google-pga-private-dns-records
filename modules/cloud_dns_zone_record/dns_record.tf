resource "google_dns_record_set" "dns_record" {
  name         = var.name
  managed_zone = var.managed_zone
  type         = var.type
  ttl          = var.ttl
  rrdatas      = var.rrdatas
}