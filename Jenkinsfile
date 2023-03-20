pipeline{
    agent any
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
                cleanWs()
            }
        }

        stage('Clone repo'){
            steps{
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

            stage('Plan') {
                steps {
                    sh 'terraform plan -no-color -out plan'
                    sh 'terraform show plan > plan.txt'
                    sh 'terraform show -json plan > tfplan.json'
                }
            }

            stage('Validate Apply') {
                steps {
                    script {
                        def plan = readFile 'plan.txt'
                        input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                } 
                    echo 'Apply Accepted'
                }
            }

        stage('apply'){
            steps{
                sh 'pwd; terraform apply -input=false plan'
            }
        }

        stage('show'){
            steps{
                sh 'pwd; terraform show'
            }
        }

        stage('destroy'){
            steps{
                sh 'pwd; terraform destroy --auto-approve'
            }
        }
    }
    post{
        success{
            echo 'Success!'
        }
        failure{
            echo 'Failure!'
        }
    }
                
}