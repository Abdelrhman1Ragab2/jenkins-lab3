pipeline {
    agent any
    
    stages {
        stage('Apply Terraform') {
            steps {
                // Checkout your Terraform code from version control
                // checkout scm
                
                // Initialize Terraform
                sh 'terraform init'
                
                // Apply Terraform changes
                sh 'terraform apply -auto-approve'
            }
        }

        stage('check ssh') {
             steps {
  
                sshagent(['ssh-1']) {
                       sh "ssh -o StrictHostKeyChecking=no ubuntu@18.200.236.142 echo hello"

                }
            }
        }
        
        stage('Apply Ansible Playbook') {
             steps {
  
                sshagent(['ssh-1']) {
                     sh "ansible-playbook -i inventory.ini playbook.yml"

                }
            }
        }
    }
    
}
