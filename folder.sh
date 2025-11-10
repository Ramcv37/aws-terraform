#!/usr/bin/env bash
set -e

# Root project folder
ROOT_DIR="webapp-iac"

# Create directory tree
echo "Creating directory structure..."
mkdir -p ${ROOT_DIR}/modules/web_app
mkdir -p ${ROOT_DIR}/envs/dev
mkdir -p ${ROOT_DIR}/envs/staging
mkdir -p ${ROOT_DIR}/envs/prod

# Create files with placeholders
echo "Creating files..."

# Module files
cat > ${ROOT_DIR}/modules/web_app/main.tf <<'EOF'
# main.tf
# Terraform module for web app infrastructure
EOF

cat > ${ROOT_DIR}/modules/web_app/variables.tf <<'EOF'
# variables.tf
# Define input variables for the web app module
EOF

cat > ${ROOT_DIR}/modules/web_app/outputs.tf <<'EOF'
# outputs.tf
# Define outputs for the web app module
EOF

# Environment: Dev
cat > ${ROOT_DIR}/envs/dev/main.tf <<'EOF'
# main.tf
# Calls the web_app module for dev environment
EOF

cat > ${ROOT_DIR}/envs/dev/dev.tfvars <<'EOF'
# dev.tfvars
# Input variables specific to the dev environment
EOF

cat > ${ROOT_DIR}/envs/dev/backend.hcl <<'EOF'
# backend.hcl
# Backend configuration for dev environment (S3 + DynamoDB)
EOF

# Environment: Staging
cat > ${ROOT_DIR}/envs/staging/main.tf <<'EOF'
# main.tf
# Calls the web_app module for staging environment
EOF

cat > ${ROOT_DIR}/envs/staging/staging.tfvars <<'EOF'
# staging.tfvars
# Input variables specific to the staging environment
EOF

cat > ${ROOT_DIR}/envs/staging/backend.hcl <<'EOF'
# backend.hcl
# Backend configuration for staging environment (S3 + DynamoDB)
EOF

# Environment: Prod
cat > ${ROOT_DIR}/envs/prod/main.tf <<'EOF'
# main.tf
# Calls the web_app module for prod environment
EOF

cat > ${ROOT_DIR}/envs/prod/prod.tfvars <<'EOF'
# prod.tfvars
# Input variables specific to the production environment
EOF

cat > ${ROOT_DIR}/envs/prod/backend.hcl <<'EOF'
# backend.hcl
# Backend configuration for production environment (S3 + DynamoDB)
EOF

# Jenkinsfile
cat > ${ROOT_DIR}/Jenkinsfile <<'EOF'
# Jenkinsfile
# CI/CD pipeline for multi-environment web app deployment
EOF

# README
cat > ${ROOT_DIR}/README.md <<'EOF'
# WebApp Infrastructure as Code (IaC)

This repository defines a Terraform-based multi-environment setup for deploying
a web application (Dev, Staging, Prod) using reusable modules and Jenkins CI/CD.
EOF

echo "✅ Directory structure and files created successfully under ${ROOT_DIR}/"

