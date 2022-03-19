data digitalocean_ssh_key aipc-server-pubkey {
  name = var.droplet_public_key
}

resource digitalocean_droplet aipc-server {
  name = "aipc-server"
  image = var.droplet_image
  region = var.droplet_region
  size = var.droplet_size
  ssh_keys = [ data.digitalocean_ssh_key.aipc-server-pubkey.id ]
  tags = [ "aipc" ]
}

resource local_file ipv4_address {
  filename = "root@${resource.digitalocean_droplet.aipc-server.ipv4_address}"
  file_permission = "0644"
  content = ""
}

resource local_file ansible_inventory {
  filename = "inventory.yaml"
  file_permission = "0644"
  content = templatefile("./inventory.tfpl", {
    hostname = resource.digitalocean_droplet.aipc-server.name
    ipv4_address = resource.digitalocean_droplet.aipc-server.ipv4_address
    private_key = pathexpand(var.droplet_private_key)
  })
}

output aipc_server_pubkey {
  description = "Server's public key"
  value = data.digitalocean_ssh_key.aipc-server-pubkey.fingerprint
}

output aipc-server-ipv4 {
  description = "IP address of the droplet"
  value = resource.digitalocean_droplet.aipc-server.ipv4_address
}
