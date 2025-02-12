output "server_public_ips" {
  description = "Public IPs of the created servers"
  value       = hcloud_server.ubuntu_server[*].ipv4_address
}

