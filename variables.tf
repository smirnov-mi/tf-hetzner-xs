variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
}

variable "server_type" {
  description = "Type of the server (default: cx22)"
  type        = string
  default     = "cx22"
}

variable "location" {
  description = "Location of the server (default: nbg1)"
  type        = string
  default     = "nbg1"
}

variable "network_interfaces" {
  description = "Network interfaces for the server (optional)"
  type        = list(any)
  default     = []
}

