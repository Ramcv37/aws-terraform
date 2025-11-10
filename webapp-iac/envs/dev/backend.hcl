bucket         = "tfstate-webapp-dev"          # create once
key            = "envs/dev/terraform.tfstate"
region         = "ap-south-1"
dynamodb_table = "tf-locks"                    # create once for all envs
encrypt        = true
# backend.hcl
# Backend configuration for dev environment (S3 + DynamoDB)
