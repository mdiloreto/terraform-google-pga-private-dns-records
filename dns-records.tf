## Private Google Access configuration for the GKE Cluster Egress traffic configuration 

######## Enable APIs 

module "dns_api" {
  source = "./modules/google_apis"
  project_id = var.project_id
  api_name = "dns.googleapis.com"
}

######### Zones 

module "googleapis_zone" {
  source = "./modules/cloud_dns_priv_zone"

  network_url  = var.network_url
  name         = "googleapis-zone"
  dns_name     = "googleapis.com."
  description  = "Private zone for googleapis.com"
}

module "gcr_zone" {
  source = "./modules/cloud_dns_priv_zone"


  network_url  = var.network_url
  name         = "gcr-zone"
  dns_name     = "gcr.io."
  description  = "Private zone for gcr.io"
}

module "pkg_zone" {
  source = "./modules/cloud_dns_priv_zone"

  network_url  = var.network_url
  name         = "pkg-zone"
  dns_name     = "pkg.dev."
  description  = "Private zone for pkg.dev"
}

module "run_zone" {
  source = "./modules/cloud_dns_priv_zone"
  
  network_url  = var.network_url
  name         = "run-zone"
  dns_name     = "run.app."
  description  = "Private zone for run.app"
}

######## Records

module "googleapis_cname_record" {
  source = "./modules/cloud_dns_zone_record"
  
  name         = "*.googleapis.com."
  managed_zone = module.googleapis_zone.zone_name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["private.googleapis.com."]

  depends_on = [module.googleapis_zone]

}

module "gcr_cname_record" {
  source = "./modules/cloud_dns_zone_record"
  
  name         = "*.gcr.io."
  managed_zone = module.gcr_zone.zone_name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["gcr.io."]

  depends_on = [module.gcr_zone]
}

module "pkg_cname_record" {
  source = "./modules/cloud_dns_zone_record"


  name         = "*.pkg.dev."
  managed_zone = module.pkg_zone.zone_name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["pkg.dev."]

  depends_on = [module.pkg_zone]

}

module "run_cname_record" {
  source = "./modules/cloud_dns_zone_record"
  
  name         = "*.run.app."
  managed_zone = module.run_zone.zone_name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["run.app."]

  depends_on = [module.run_zone]
}

module "googleapis_a_records" {
  source = "./modules/cloud_dns_zone_record"
  
  name         = "googleapis.com."
  managed_zone = module.googleapis_zone.zone_name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [module.googleapis_zone]
}

module "gcr_a_records" {
  source = "./modules/cloud_dns_zone_record"

  name         = "gcr.io."
  managed_zone = module.gcr_zone.zone_name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [module.gcr_zone]
}

module "pkg_a_records" {
  source = "./modules/cloud_dns_zone_record"
 
  name         = "pkg.dev."
  managed_zone = module.pkg_zone.zone_name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [module.pkg_zone]
}

module "run_a_records" {
  source = "./modules/cloud_dns_zone_record"

  name         = "run.app."
  managed_zone = module.run_zone.zone_name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [module.run_zone]
}
