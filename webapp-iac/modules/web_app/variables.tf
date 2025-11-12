# ────────────────────────────────
# Existing variables (kept as-is)
# ────────────────────────────────
variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ssh_cidr_blocks" {
  type = list(string)
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}

# ────────────────────────────────
# New variables for Web-App setup
# ────────────────────────────────

# Friendly name shown on the web page
variable "app_name" {
  description = "Display name of the web application"
  type        = string
  default     = "Dell Moogsoft"
}

# HTTP/Custom app port to expose
variable "app_port" {
  description = "Port used by the Nginx web app (e.g. 8080 for dev, 80 for prod)"
  type        = number
  default     = 80
}

# Optional: override SSH access range per environment
variable "ssh_cidr" {
  description = "CIDR block allowed for SSH access (used if you prefer a single string)"
  type        = string
  default     = "0.0.0.0/0"
}
