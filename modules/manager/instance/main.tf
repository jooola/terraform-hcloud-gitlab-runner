locals {
  name = "${var.name}-manager"
  labels = {
    managed-by : "terraform"
  }
}

data "cloudinit_config" "self" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      package_update  = true
      package_upgrade = true

      swap = {
        filename = "/var/swap.bin"
        size     = "auto"
        maxsize  = 4294967296 # 4GB
      }
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/files/install-gitlab-runner.sh", {
      version = var.runner_version
    })
  }

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      users = [
        {
          name  = "gitlab-runner"
          gecos = "Gitlab Runner"
          shell = "/usr/bin/bash"
        }
      ]

      write_files = [
        {
          path        = "/etc/systemd/system/gitlab-runner.service"
          owner       = "root:root"
          permissions = "0644"
          content     = templatefile("${path.module}/files/gitlab-runner.service", {})
        }
      ]
    })
  }
}

resource "hcloud_server" "self" {
  name   = local.name
  labels = local.labels

  server_type = var.hcloud_server_type
  location    = var.hcloud_location
  ssh_keys    = var.hcloud_ssh_keys
  image       = "debian-12"
  user_data   = data.cloudinit_config.self.rendered

  connection {
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = ["cloud-init status --wait || test $? -eq 2"]
  }
}

resource "terraform_data" "config" {
  triggers_replace = [
    hcloud_server.self.id,
  ]

  connection {
    host = hcloud_server.self.ipv4_address
  }

  provisioner "file" {
    content     = var.runner_config
    destination = "/home/gitlab-runner/config.toml"
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl enable gitlab-runner.service",
      "systemctl restart gitlab-runner.service",
    ]
  }
}

resource "hcloud_firewall" "self" {
  name   = local.name
  labels = local.labels

  rule {
    description = "allow icmp from everywhere"
    direction   = "in"
    protocol    = "icmp"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }

  rule {
    description = "allow ssh from everywhere"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_firewall_attachment" "self" {
  firewall_id = hcloud_firewall.self.id
  server_ids  = [hcloud_server.self.id]
}
