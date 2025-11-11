variable "project"          { type = string }
variable "environment"      { type = string }
variable "owner"            { type = string }

variable "region"           { type = string }          # ✅ ensure this exists
variable "vpc_id"           { type = string }
variable "public_subnet_id" { type = string }
variable "instance_type"    { type = string }
variable "ssh_cidr_blocks"  { type = list(string) }
variable "extra_tags"       { type = map(string) default = {} }

output "web_public_ip" {
  value = module.web.web_public_ip
}
