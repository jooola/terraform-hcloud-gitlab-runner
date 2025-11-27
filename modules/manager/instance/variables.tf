variable "name" {
  description = "Name of the Gitlab CI infrastructure"
  type        = string
}

variable "runner_version" {
  description = "Version of the Gitlab Runner to install"
  type        = string
}

variable "runner_config" {
  description = "Gitlab Runner config to install"
  type        = string
}


variable "hcloud_location" {
  description = "Location of the Gitlab Runner manager"
  type        = string
}

variable "hcloud_server_type" {
  description = "Server Type of the Gitlab Runner manager"
  type        = string
}

variable "hcloud_ssh_keys" {
  description = "SSH Keys to attach to the Gitlab Runner manager"
  type        = list(string)
  default     = []
}
