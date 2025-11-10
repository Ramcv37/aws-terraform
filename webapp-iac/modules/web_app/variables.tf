variable "project"         { type = string }
variable "environment"     { type = string }
variable "owner"           { type = string }
variable "region"          { type = string }
variable "instance_type"   { type = string  default = "t3.micro" }
variable "vpc_id"          { type = string }
variable "public_subnet_id"{ type = string }
variable "ssh_cidr_blocks" { type = list(string) default = [] }
variable "extra_tags"      { type = map(string) default = {} }
# variables.tf
# Define input variables for the web app module
