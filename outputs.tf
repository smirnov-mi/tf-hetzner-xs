output "server_public_ips" {
  description = "Public IPs of the created servers"
  value       = hcloud_server.ubuntu_server[*].ipv4_address
}

output "add_text_server_public_ips" {
  description = "how to print Public IPs of the created servers"
  value =  " RUN   terraform output -json server_public_ips | jq -r '.[]'  to get a list of new Public IPs"
}
