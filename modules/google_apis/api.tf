resource "google_project_service" "dns" {
  project = var.project_id
  service = var.api_name
  disable_on_destroy = false
}