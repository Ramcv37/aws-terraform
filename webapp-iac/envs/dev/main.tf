terraform {}

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

variable "region"           { type = string }
variable "vpc_id"           { type = string }
variable "public_subnet_id" { type = string }
variable "instance_type"    { type = string }
variable "ssh_cidr_blocks"  { type = list(string) }
variable "extra_tags"       { type = map(string) default = {} }

output "web_public_ip" {
  value = module.web.web_public_ip
}
