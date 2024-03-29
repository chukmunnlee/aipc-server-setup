terraform {
  required_version = ">= 1.0.0"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.18.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.2"
    }
  }
  backend s3 {
    skip_credentials_validation = true
    skip_region_validation = true
    skip_metadata_api_check = true
    endpoint = "https://sgp1.digitaloceanspaces.com"
    region = "sgp1"
    bucket = "bigbucket"
    key = "states/terraform.tfstate"
  }
}

provider digitalocean {
  token = var.DO_token
}

provider local { }
