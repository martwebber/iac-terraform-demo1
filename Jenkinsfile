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

        stage('Terraform plan'){
            steps{
                sh 'terraform plan --input=false -out tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt; ls'
            }
        }

        stage('infracost') {
                agent {
                    docker {
                        image 'infracost/infracost:ci-0.9'
                            reuseNode true
                            args "--user=mart --privileged -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=''"
                    }
                }
                // Set up any required credentials for posting the comment, e.g. GitHub token, GitLab token
                    environment {
                        INFRACOST_API_KEY = credentials('INFRACOST_API_KEY')
                    }
                    steps {
                        // unstash 'tfplan_json'
                        sh 'infracost breakdown --path tfplan.json --show-skipped --format html --out-file infracost.html'
                    }
            }

        stage('Approval'){
            when{
                not{
                    equals expected: true, actual: params.autoApprove
                }
            }

            steps{
                script{
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the file?", parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
                echo 'Approved'
            }
        }

        stage('apply'){
            steps{
                sh 'pwd; terraform apply -input=false tfplan'
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