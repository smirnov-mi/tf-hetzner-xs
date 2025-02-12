terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = ">= 1.35.0" # Optional, can specify the version you want
    }
  }
  required_version = ">= 1.0.0"
}

provider "hcloud" {
  token = var.hcloud_token # Ensure that this variable is set
}

# Create the SSH key on Hetzner
resource "hcloud_ssh_key" "init_key" {
  name       = "init-key"
  public_key = file("~/.ssh/id_ed25519.pub")  # Path to your public key (ensure the correct path)
}

resource "hcloud_server" "ubuntu_server" {
  count = 2

  name        = "server-${count.index + 1}"
  image       = "ubuntu-24.04"
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.init_key.id]

#  ssh_keys = [file("~/.ssh/id_ed25519.pub")]  # Use your SSH key for authorization

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

  labels = {
    "muscat-server" = "true"
  }

}

