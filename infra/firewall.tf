resource "digitalocean_firewall" "vaultwarden_firewall" {
  name = "vaultwarden-ssh-http-and-https"
  droplet_ids = [
    digitalocean_droplet.vaultwarden_server.id
  ]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"] # Required for ACME HTTP-01 challenge
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = var.allowed_source_ips
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.allowed_source_ips
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
