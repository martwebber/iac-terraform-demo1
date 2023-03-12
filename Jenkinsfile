pipeline{
    agent any
    parameters{
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for the deploymet')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating the plan?')
    }
    tools {
        terraform 'terraform'
}
    environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
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
                sh 'pwd; ls; terraform init'
            }
        }

        stage('Terraform validate'){
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