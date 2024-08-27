output "rendered" {
  value = templatefile("${path.module}/files/config.toml", {
    runner_name  = "${var.name}"
    runner_url   = var.runner_url
    runner_token = var.runner_token

    hcloud_name        = "${var.name}"
    hcloud_token       = var.hcloud_token
    hcloud_location    = var.hcloud_location
    hcloud_server_type = var.hcloud_server_type
    hcloud_user_data   = data.cloudinit_config.self.rendered
  })
  sensitive = true
}
