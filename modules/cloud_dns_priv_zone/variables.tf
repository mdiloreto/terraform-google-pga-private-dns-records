variable "name" {
  description = "The name of the DNS managed zone."
  type        = string
}

variable "dns_name" {
  description = "The DNS name of the managed zone."
  type        = string
}

variable "description" {
  description = "The description of the managed zone."
  type        = string
  default     = ""
}

variable "network_url" {
  description = "This is the network id that will have visibility of the zone in the private_visibility_config."
}