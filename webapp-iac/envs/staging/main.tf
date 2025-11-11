terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "web" {
  source = "../../modules/web_app"

  project          = var.project
  environment      = var.environment
  owner            = var.owner

  region           = var.region              # ✅ required
  vpc_id           = var.vpc_id
  public_subnet_id = var.public_subnet_id
  instance_type    = var.instance_type
  ssh_cidr_blocks  = var.ssh_cidr_blocks
}

output "web_public_ip" {
  value = module.web.web_public_ip
}
