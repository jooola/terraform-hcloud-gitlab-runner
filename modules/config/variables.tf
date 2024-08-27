variable "name" {
  description = "Name of the Gitlab CI infrastructure"
  type        = string
}

variable "runner_url" {
  description = "URL of the GitLab instance the GitLab Runner will connect to"
  type        = string
}

variable "runner_token" {
  description = "Token to communicate with the GitLab instance the GitLab Runner will connect to"
  type        = string
}


variable "hcloud_token" {
  description = "Token to communicate with the Hetzner Cloud API"
  type        = string
}

variable "hcloud_location" {
  description = "Location of the Gitlab Runner workers"
  type        = string
}

variable "hcloud_server_type" {
  description = "Server Type of the Gitlab Runner workers"
  type        = string
}

variable "hcloud_ssh_keys" {
  description = "SSH Keys to attach to the Gitlab Runner workers"
  type        = list(string)
  default     = []
}
