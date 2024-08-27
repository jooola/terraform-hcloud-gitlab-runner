locals {
  gitlab_url   = "https://gitlab.com"
  gitlab_token = "<GITLAB_TOKEN>"

  hcloud_token = "<HCLOUD_TOKEN>"
}

resource "gitlab_user_runner" "runner" {
  runner_type = "project_type"
  project_id  = 123456

  description = "Docker Autoscaler runner on Hetzner Cloud"
  untagged    = true
}

data "hcloud_ssh_keys" "all" {}

module "runner" {
  source = "../"

  count = 2
  name  = "runner-${count.index}-docker-autoscaler"

  runner_version = "v17.3.1"
  runner_url     = local.gitlab_url
  runner_token   = gitlab_user_runner.runner.token

  hcloud_token       = local.hcloud_token
  hcloud_location    = "hel1"
  hcloud_server_type = "cpx21"
  hcloud_ssh_keys    = [for i in data.hcloud_ssh_keys.all.ssh_keys : i.name]
}


