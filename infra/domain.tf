resource "digitalocean_domain" "vaultwarden_domain" {
  name       = var.domain
  ip_address = digitalocean_droplet.vaultwarden_server.ipv4_address
}
