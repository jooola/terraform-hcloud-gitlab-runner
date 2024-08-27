data "hcloud_datacenters" "all" {}

locals {
  datacenter = [for i in data.hcloud_datacenters.all : i.name if i.location.name == var.location][0]
  labels     = merge(var.labels, { "ip-pool" : var.name })
}

resource "hcloud_primary_ip" "ipv4" {
  count = var.ipv4_enabled ? var.size : 0

  type       = "ipv4"
  name       = "${var.name}-ipv4-${count.index}"
  labels     = local.labels
  datacenter = local.datacenter

  assignee_type = "server"
  auto_delete   = false
}

resource "hcloud_primary_ip" "ipv6" {
  count = var.ipv6_enabled ? var.size : 0

  type       = "ipv6"
  name       = "${var.name}-ipv6-${count.index}"
  labels     = local.labels
  datacenter = local.datacenter

  assignee_type = "server"
  auto_delete   = false
}
