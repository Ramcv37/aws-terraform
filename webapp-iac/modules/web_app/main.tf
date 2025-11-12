terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  tags = merge({
    project     = var.project
    environment = var.environment
    owner       = var.owner
  }, var.extra_tags)

  name_prefix = "${var.project}-${var.environment}"
}

# ────────────────────────────────
# Fetch latest Ubuntu AMI
# ────────────────────────────────
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# ────────────────────────────────
# Security Group
# ────────────────────────────────
resource "aws_security_group" "web" {
  name        = "${local.name_prefix}-web-sg"
  description = "Allow WebApp Port and SSH"
  vpc_id      = var.vpc_id

  # App port (dev/staging can be 808x, prod 80)
  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  # Egress all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${local.name_prefix}-web-sg" })
}

# ────────────────────────────────
# User data: install nginx + page
# ────────────────────────────────
locals {
  user_data = <<-EOF
    #!/bin/bash
    set -e
    export DEBIAN_FRONTEND=noninteractive

    apt-get update -y
    apt-get install -y nginx

    # Write the landing page
    cat >/var/www/html/index.html <<HTML
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Welcome Dell Moogsoft - ${var.environment}</title>
      <style>
        body { font-family: Arial, sans-serif; background:#0b1b2b; color:#fff;
               display:flex; justify-content:center; align-items:center; height:100vh; margin:0; }
        .box { text-align:center; background:#13283c; padding:40px 60px; border-radius:16px; box-shadow:0 8px 24px rgba(0,0,0,.4);}
        h1 { font-size:2em; margin-bottom:8px; }
        span.env { display:inline-block; padding:4px 12px; border-radius:8px; font-weight:bold; background:#0ea5e9; }
      </style>
    </head>
    <body>
      <div class="box">
        <h1>Welcome Dell Moogsoft</h1>
        <span class="env">${upper(var.environment)}</span>
        <p>Application: ${var.app_name}</p>
      </div>
    </body>
    </html>
    HTML

    # Configure nginx to listen on custom port if not 80
    PORT="${var.app_port}"
    if [ "$PORT" != "80" ]; then
      cat >/etc/nginx/sites-available/webapp <<NGINX
    server {
        listen $${PORT} default_server;
        root /var/www/html;
        index index.html;
        location / {
            try_files \\$uri \\$uri/ =404;
        }
    }
    NGINX
      ln -sf /etc/nginx/sites-available/webapp /etc/nginx/sites-enabled/webapp
      rm -f /etc/nginx/sites-enabled/default || true
    fi

    systemctl enable nginx
    systemctl restart nginx
  EOF
}

# ────────────────────────────────
# EC2 Instance
# ────────────────────────────────
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = local.user_data

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-web"
    app  = var.app_name
  })
}

# ────────────────────────────────
# Outputs
# ────────────────────────────────
output "web_public_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the WebApp instance"
}

output "web_url" {
  value       = "http://${aws_instance.web.public_ip}:${var.app_port}"
  description = "URL to access the web application"
}
