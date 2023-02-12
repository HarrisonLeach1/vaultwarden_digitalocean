resource "digitalocean_droplet" "vaultwarden_server" {
  image   = "ubuntu-22-04-x64"
  name    = "vaultwarden-server"
  region  = var.droplet_region
  size    = var.droplet_size
  backups = var.droplet_backups_enabled
  ssh_keys = [
    data.digitalocean_ssh_key.vaultwarden_ssh_key.id
  ]

  connection {
    host    = self.ipv4_address
    user    = "root"
    type    = "ssh"
    agent   = true
    timeout = "2m"
  }

  # Use provisioner instead of user_data arg because it logs during terraform apply
  provisioner "remote-exec" {
    script = "${path.module}/scripts/user_data.sh"
  }

  provisioner "file" {
    source      = "${path.module}/../vw/"
    destination = "/srv/vw"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/init.sh"
  }
}
