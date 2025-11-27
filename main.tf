data "hcloud_ssh_keys" "all" {
  with_selector = "type=user"
}

locals {
  # TODO: improve ssh keys handling
  hcloud_ssh_keys = [for i in data.hcloud_ssh_keys.all.ssh_keys : i.name]
}

module "config" {
  source = "./modules/config"

  name = var.name

  runner_url   = var.runner_url
  runner_token = var.runner_token

  hcloud_token       = var.hcloud_token
  hcloud_location    = var.hcloud_location
  hcloud_server_type = var.hcloud_server_type
  hcloud_ssh_keys    = local.hcloud_ssh_keys
}

module "manager" {
  source = "./modules/manager/instance"

  name = var.name

  runner_config  = module.config.rendered
  runner_version = var.runner_version

  # TODO: allow using different variables for the manager
  hcloud_location    = var.hcloud_location
  hcloud_server_type = var.hcloud_server_type
  hcloud_ssh_keys    = local.hcloud_ssh_keys
}
