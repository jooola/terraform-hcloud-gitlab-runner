variable "name" {
  description = "Name of the IP pool"
  type        = string
}

variable "size" {
  description = "Size of the IP pool"
  type        = number
}

variable "location" {
  description = "Location of the IP in the pool"
  type        = string
}

variable "ipv4_enabled" {
  description = "Enable IPv4 in the IP pool"
  type        = bool
  default     = true
}

variable "ipv6_enabled" {
  description = "Enable IPv6 in the IP pool"
  type        = bool
  default     = true
}

variable "labels" {
  description = "Labels to attach to the IP in the pool"
  type        = map(string)
  default     = {}
}
