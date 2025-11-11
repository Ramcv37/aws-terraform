module "web" {
  source           = "../../modules/web_app"
  project          = var.project
  environment      = var.environment
  owner            = var.owner
  instance_type    = var.instance_type
  vpc_id           = var.vpc_id
  public_subnet_id = var.public_subnet_id
  ssh_cidr_blocks  = var.ssh_cidr_blocks
}

output "web_public_ip" {
  value = module.web.web_public_ip
}
