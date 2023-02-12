resource "digitalocean_project" "vaultwarden_project" {
  name        = "vaultwarden"
  description = "A project containing resources for a vaultwarden server"
  purpose     = "Service or API"
  resources   = [digitalocean_droplet.vaultwarden_server.urn, digitalocean_domain.vaultwarden_domain.urn]
}
