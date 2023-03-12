pipeline{
    agent any
    tools {
        terraform 'terraform'
}

    stages{
        stage('Clean workspace'){
            steps{
                echo 'Cleaning workspace...'
            }
        }

        stage('Clone repo'){
            steps{
                //echo 'checkout code...'
                checkout scmGit(branches: [[name: '*/dev-h']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/martwebber/iac-terraform-demo1.git']])
            }
        }

        stage('Terraform init'){
            steps{
                sh 'terraform init'
            }
        }

        ('Terraform validate'){
            steps{
                sh 'terraform validate'
            }
        }

        stage('Terraform plan'){
            steps{
                sh 'terraform plan'
            }
        }
    }
}