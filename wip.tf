locals {
  runner_config = {
    concurrent     = 1
    check_interval = 0

    log_level  = "info"
    log_format = "text"
    runners = [
      {
        name     = "hetzner-docker-autoscaler"
        url      = "https://gitlab.com"
        token    = ""
        executor = "docker-autoscaler"

        docker = {
          image   = "alpine:latest"
          volumes = ["/cache"]
        }
        autoscaler = {
          capacity_per_instance = 2
          max_instances         = 5
          max_use_count         = 0

          policy = {
            idle_count = 4
            idle_time  = "20m0s"
          }

          plugin = "fleeting-plugin-hetzner"
          plugin_config = {
            name  = "dev-docker-autoscaler"
            token = ""

            location    = "hel1"
            server_type = "cpx21"
            image       = "ubuntu-24.04"

            user_data = ""
          }

          instance_ready_command = "cloud-init status --wait || test $? -eq 2"

          connector_config = {
            use_external_addr      = true
            use_static_credentials = true
            username               = "root"
            key_path               = "./id_ed25519"
          }
        }
      }
    ]
  }
}
