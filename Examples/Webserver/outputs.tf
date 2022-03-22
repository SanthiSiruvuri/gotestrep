# Output the instance's public IP address.
output "public_ip" {
  value = module.webserver.public_ip
}