terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.48"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = ">= 17.3.0"
    }
  }
}

provider "hcloud" {
  token = local.hcloud_token
}

provider "gitlab" {
  base_url = local.gitlab_url
  token    = local.gitlab_token
}
