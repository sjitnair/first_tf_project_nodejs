pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "us-east-1" 
        TF_IN_AUTOMATION   = "true"
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Terraform action'
        )
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/sjitnair/first_tf_project_nodejs.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                terraform init -input=false
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                terraform plan -var-file=dev.tfvars -out=tfplan
                '''
            }
        }

        stage('Terraform Apply / Destroy') {
            steps {
                script {
                    // Use ACTION variable here
                    if (ACTION == 'apply') {
                        sh 'terraform apply -auto-approve tfplan'
                    } else if (ACTION == 'destroy') {
                        sh 'terraform destroy -auto-approve'
                    } else {
                        error "Invalid ACTION: ${ACTION}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Terraform deployment completed successfully."
        }
        failure {
            echo "Terraform deployment failed."
        }
    }
}

