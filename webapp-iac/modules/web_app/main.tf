pipeline {
  agent any
  options { timestamps() }

  parameters {
    booleanParam(name: 'AUTO_APPROVE', defaultValue: true, description: 'Auto-approve terraform apply')
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm

        script {
          def branch = env.BRANCH_NAME ?: sh(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
          env.BRANCH_NAME = branch

          env.TARGET_ENV = (branch == 'master')  ? 'prod'
                        : (branch == 'staging') ? 'staging'
                        : 'dev'

          env.ENV_DIR  = "webapp-iac/envs/${env.TARGET_ENV}"
          env.VAR_FILE = "${env.TARGET_ENV}.tfvars"

          echo "✔ Branch: ${env.BRANCH_NAME}"
          echo "✔ Deploying to: ${env.TARGET_ENV}"
          echo "✔ Env Path: ${env.ENV_DIR}"
        }
      }
    }

    stage('Terraform Init & Plan') {
      steps {
        script {
          def cred = "aws-dev-iam"
          echo "🔑 Using AWS Credential: ${cred}"

          withAWS(credentials: cred, region: 'ap-south-1') {
            dir("${env.ENV_DIR}") {

              sh '''
                set -e
                terraform --version
                terraform init -reconfigure        # ✅ local backend (no backend.hcl)
                terraform validate
              '''

              sh "terraform plan -var-file=${env.VAR_FILE} -out=tfplan.bin"
            }
          }
        }
      }
    }

    stage('Terraform Apply') {
      when { expression { return params.AUTO_APPROVE } }
      steps {
        script {
          def cred = "aws-dev-iam"
          withAWS(credentials: cred, region: 'ap-south-1') {
            dir("${env.ENV_DIR}") {
              sh "terraform apply -auto-approve tfplan.bin"
            }
          }
        }
      }
    }
  }

  post {
    always {
      script {
        dir("${env.ENV_DIR}") {
          sh "terraform output || true"
        }
      }
    }
  }
}
