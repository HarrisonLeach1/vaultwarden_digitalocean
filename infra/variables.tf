variable "droplet_region" {
  description = "Region of the Digital Ocean server to provision"
  type        = string
}

variable "droplet_size" {
  description = "Size of the Digital Ocean server to provision"
  type        = string
}

variable "domain" {
  description = "The domain of your vaultwarden instance"
  type        = string
}

variable "personal_access_token" {
  description = "Your Digital Ocean personal access token. It should have write permissions"
  sensitive   = true
  type        = string
}

variable "ssh_key_digitalocean_name" {
  description = "The name of your ssh key on Digital Ocean"
  type        = string
}

variable "droplet_backups_enabled" {
  description = "(Optional) If enabled, creates weekly backups of the vaultwarden server"
  type        = bool
  default     = true
}

variable "allowed_source_ips" {
  description = "(Optional) An array of strings containing the IPv4 addresses, IPv6 addresses, IPv4 CIDRs, and/or IPv6 CIDRs you want the vaultwarden server to be accessible from"
  type        = list(string)
  default     = ["0.0.0.0/0", "::/0"]
}
