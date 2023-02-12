# Vaultwarden Digital Ocean

(Mostly) automated setup of [vaultwarden](https://github.com/dani-garcia/vaultwarden) on Digital Ocean.

## Overview

This project sets up a self-hosted vaultwarden server with:

-   Automated HTTPs and certificate management using [Caddy proxy](https://caddyserver.com/docs/automatic-https)
-   Fail2Ban - Bans IPs attempting brute-force attacks and sends email alerts
-   Automated OS patching and vaultwarden image updates

## Pre-requisites

1.  A Digital Ocean account
2.  A Digital Ocean [personal access token](https://docs.digitalocean.com/reference/api/create-personal-access-token/) with write access
3.  An [ssh key uploaded to Digital Ocean](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/to-team/) that is also available on your device
4.  [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
5.  Domain name registered with access to modify its DNS records

## Setup steps

### 1. Create `.env` file

Clone this repo. In `./vw` copy `.env.template` to a file named `.env` and fill out the variables.

### 2. Create `terraform.tfvars` file

In `./infra` copy `terraform.tfvars.template` to a file named `terraform.tfvars` and fill out the variables.

### 3. Point to Digital Ocean from your domain registrar

This project assumes you'd want the vaultwarden server accessible from a subdomain of an existing domain of yours.

To do this, in your domain registrar create an NS record for your subdomain which points to the three Digital Ocean nameservers (`ns1.digitalocean.com`, `ns2.digitalocean.com`, `ns3.digitalocean.com`).

For example, the record in your domain registrar should be similar to:

| Host name               | Type | TTL  | Data                                                                    |
| ----------------------- | ---- | ---- | ----------------------------------------------------------------------- |
| vaultwarden.example.com | NS   | 3600 | ns1.digitalocean.com.<br>ns2.digitalocean.com.<br>ns3.digitalocean.com. |

### 4. Ensure your ssh agent is running and has your ssh key

-   Start the ssh-agent: `eval "$(ssh-agent -s)"`
-   Add your private key (from pre-requisite 3) to the ssh-agent: `ssh-add ~/.ssh/<your_private_key>`

### 5. Setup infrastructure via terraform

In the `./infra` directory:

Initialise terraform backend:

```
terraform init
```

Apply terraform changes:

```
terraform apply
```

The infra provisioning should take ~4 mins.

After provisioning it should take ~1 min for vaultwarden to be accessible at your subdomain.

## Notes

-   OS patching is automated via [unattended-upgrades](https://wiki.debian.org/UnattendedUpgrades). On days where patching is required, system reboots are scheduled for 3am (based on TZ).
