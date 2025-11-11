region           = "ap-south-1"
vpc_id           = "vpc-0123456789abcdef0"      # CHANGE THIS
public_subnet_id = "subnet-0123456789abcdef0"   # CHANGE THIS
instance_type    = "t3.micro"

# Only Jenkins can SSH (Laptop IP can be added later)
ssh_cidr_blocks  = ["132.237.185.251/32"]

extra_tags = {
  cost_center = "cc-dev"
}
