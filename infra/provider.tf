terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.personal_access_token
}

data "digitalocean_ssh_key" "vaultwarden_ssh_key" {
  name = var.ssh_key_digitalocean_name
}
