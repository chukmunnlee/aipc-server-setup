data digitalocean_ssh_key chuk {
  name = "chuk"
}

resource digitalocean_droplet aipc-mar22 {
  name = "aipc-mar22"
  image = var.droplet_image
  region = var.droplet_region
  size = var.droplet_size
  ssh_keys = [ data.digitalocean_ssh_key.chuk.id ]
  tags = [ "aipc" ]
}

resource local_file ipv4_address {
  filename = "root@${resource.digitalocean_droplet.aipc-mar22.ipv4_address}"
  file_permission = "0644"
  content = ""
}

resource local_file ansible_inventory {
  filename = "inventory.yaml"
  file_permission = "0644"
  content = templatefile("./inventory.tfpl", {
    hostname = resource.digitalocean_droplet.aipc-mar22.name
    ipv4_address = resource.digitalocean_droplet.aipc-mar22.ipv4_address
    private_key = pathexpand(var.droplet_private_key)
  })
}

output chuk_pubkey {
  description = "Chuk's public key"
  value = data.digitalocean_ssh_key.chuk.fingerprint
}

output apic-mar22-ipv4 {
  description = "IP address for the droplet"
  value = resource.digitalocean_droplet.aipc-mar22.ipv4_address
}
