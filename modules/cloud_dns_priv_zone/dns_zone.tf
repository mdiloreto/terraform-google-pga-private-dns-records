resource "google_dns_managed_zone" "dns_private_zone" {
  name        = var.name
  dns_name    = var.dns_name 
  visibility  = "private"
  description = var.description

  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
} 