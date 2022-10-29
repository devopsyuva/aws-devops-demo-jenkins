pipeline {
    agent {
        label 'terraform'
    }
    environment { 
        AWS_ACCESS_KEY_ID     = credentials('aws_secret_key_id') 
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
    }
    stages {
        stage('Initialize Terraform') {
            sh 'terraform init'
        }
        stage('Format config files') {
            sh 'terraform fmt -check=0 || exit 1'
        }
        stage('Validate config files') {
            sh 'terraform validate'
        }
        stage('Generate Plan') {
            sh 'terraform plan -out=terraformplan'
            sh 'terraform show -json ./terraformplan > terraform_plan.json'
        }
        stage('Publish artifacts for terraform plan') {
            steps {
                archiveArtifacts artifacts: 'terraform_plan.json', excludes: 'output/*.md', onlyIfSuccessful: true
            }
        }
        stage('Run terraform apply or not?') {
            steps {
                script {
                    env.selected_action = input  message: 'Select action to perform',ok : 'Proceed',id :'tag_id',
                    parameters:[choice(choices: ['apply', 'destroy', 'abort'], description: 'Select action', name: 'action')]
                }
            }
        }
        stage('Terraform apply') { 
            steps {
                if (env.selected_action == "apply") {
                    sh 'terraform apply -auto-approve'
                } else if (env.selected_action == "destroy") {
                    sh 'terraform destroy -auto-approve'
                } else {
                    sh 'No need to create a resource as of now,so aborted!!!'
                }
            } 
        }
    }
}