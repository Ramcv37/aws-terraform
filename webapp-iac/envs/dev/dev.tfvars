region           = "ap-south-1"
vpc_id           = "vpc-0b0c85920eea6a819"      # CHANGE THIS
public_subnet_id = "subnet-07f78d72be81be9c4"   # CHANGE THIS
instance_type    = "t3.micro"

# Only Jenkins can SSH (Laptop IP can be added later)
ssh_cidr_blocks  = ["132.237.185.251/32"]

extra_tags = {
  cost_center = "cc-dev"
}
