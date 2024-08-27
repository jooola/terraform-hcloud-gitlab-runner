variable "name" {
  description = "Name of the Gitlab CI infrastructure"
  type        = string
}

variable "runner_url" {
  description = "URL of the GitLab instance"
  type        = string
}

variable "runner_token" {
  description = "Token to communicate with the GitLab instance"
  type        = string
}

variable "runner_version" {
  description = "Version of the Gitlab Runner to install"
  type        = string
}


variable "hcloud_token" {
  description = "Token to communicate with the Hetzner Cloud API"
  type        = string
}

variable "hcloud_location" {
  description = "Location of the instances"
  type        = string
}

variable "hcloud_server_type" {
  description = "Server Type of the instances"
  type        = string
}

variable "hcloud_ssh_keys" {
  description = "SSH Keys to attach to the instances"
  type        = list(string)
  default     = []
}

