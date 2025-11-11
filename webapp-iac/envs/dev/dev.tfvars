project          = "webapp"
environment      = "dev"
owner            = "raji"

region           = "ap-south-1"
vpc_id           = "vpc-0b0c85920eea6a819"
public_subnet_id = "subnet-07f78d72be81be9c4"

instance_type    = "t3.micro"

ssh_cidr_blocks = ["132.237.185.251/32"]  # Your laptop IP

extra_tags = {
  app = "demo"
}
