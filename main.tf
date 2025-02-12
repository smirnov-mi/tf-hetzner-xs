provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_server" "ubuntu_server" {
  count = 2

  name        = "server-${count.index + 1}"
  image       = "ubuntu-24.04"
  server_type = var.server_type
  location    = var.location

  ssh_keys = [file("~/.ssh/id_ed25519.pub")]  # Use your SSH key for authorization

  # Cloud-init configuration to create "muscat" user with sudo privileges
  user_data = <<-EOF
    #cloud-config
    users:
      - name: muscat
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh-authorized-keys:
          - ${file("~/.ssh/id_ed25519.pub")}
    ssh_pwauth: false
    disable_root: true
  EOF

  tags = ["muscat-server"]

  # Outputs public IPs
  dynamic "network_interface" {
    for_each = length(var.network_interfaces) > 0 ? var.network_interfaces : []
    content {
      ipv4_address = network_interface.value.ipv4_address
    }
  }
}

output "server_public_ips" {
  value = hcloud_server.ubuntu_server[*].ipv4_address
}

