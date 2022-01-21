terraform {
  required_version = "~> 1.1.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.6.3"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }

  backend "local" {
    path = "../secrets/paulynomial.tfstate"
  }
}


# Secrets management
provider sops {}

data sops_file cloudflared_creds {
  source_file = "../secrets/cloudflared.sops.yaml"
  input_type  = "yaml"
}

provider "cloudflare" {
  email     = data.sops_file.cloudflared_creds.data["stringData.email"]
  api_token = data.sops_file.cloudflared_creds.data["stringData.api_token"]
}
