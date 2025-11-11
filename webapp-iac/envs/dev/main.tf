terraform {
  # backend is injected via -backend-config=backend.hcl
}

module "web" {
  source           = "../../modules/web_app"
  project          = "webapp"
  environment      = "dev"
  owner            = "platform"

  region           = var.region
  vpc_id           = var.vpc_id
  public_subnet_id = var.public_subnet_id
  instance_type    = var.instance_type
  ssh_cidr_blocks  = var.ssh_cidr_blocks
  extra_tags       = var.extra_tags
}

output "web_public_ip" {
  value = module.web.web_public_ip
}
