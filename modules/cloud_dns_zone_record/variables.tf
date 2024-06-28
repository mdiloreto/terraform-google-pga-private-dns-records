variable "name" {
  description = "The name of the DNS record set."
  type        = string
}

variable "managed_zone" {
  description = "The name or ID of the managed zone."
  type        = string
}

variable "type" {
  description = "The type of the DNS record set (e.g., A, CNAME)."
  type        = string
}

variable "ttl" {
  description = "The time to live for the DNS record set, in seconds."
  type        = number
}

variable "rrdatas" {
  description = "The list of resource record data values."
  type        = list(string)
}
