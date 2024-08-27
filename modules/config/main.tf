data "cloudinit_config" "self" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      package_update  = true
      package_upgrade = true

      apt = {
        sources = {
          "docker.list" = {
            source = "deb [signed-by=$KEY_FILE] https://download.docker.com/linux/debian $RELEASE stable"
            keyid  = "9DC858229FC7DD38854AE2D88D81803C0EBFCD88"
          }
        }
      }

      packages = [
        "ca-certificates",
        "docker-ce",
      ]

      swap = {
        filename = "/var/swap.bin"
        size     = "auto"
        maxsize  = 4294967296 # 4GB
      }
    })
  }
}
