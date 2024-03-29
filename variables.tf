variable DO_token {
  type = string
  sensitive = true
}

variable droplet_private_key {
  type = string
  sensitive = true
}

variable droplet_public_key {
  type = string
}

variable droplet_region {
  type = string
  default = "sgp1"
}

variable droplet_image {
  type = string
  default = "ubuntu-20-04-x64"
}

variable droplet_size {
  type = string
  default = "s-1vcpu-2gb"
}

