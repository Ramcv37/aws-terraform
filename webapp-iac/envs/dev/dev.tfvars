region           = "ap-south-1"
vpc_id           = "vpc-0123456789abcdef0"
public_subnet_id = "subnet-0123456789abcdef0"
instance_type    = "t3.micro"
ssh_cidr_blocks  = ["203.0.113.10/32"] # replace with your IP
extra_tags = { cost_center = "cc-dev" }
# dev.tfvars
# Input variables specific to the dev environment
