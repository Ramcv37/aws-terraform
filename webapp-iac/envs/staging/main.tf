module "web" {
  source           = "../../modules/web_app"
  project          = var.project
  environment      = var.environment
  owner            = var.owner

  region           = var.region              # ✅ required
  vpc_id           = var.vpc_id
  public_subnet_id = var.public_subnet_id
  instance_type    = var.instance_type
  ssh_cidr_blocks  = var.ssh_cidr_blocks
  extra_tags       = var.extra_tags
}
