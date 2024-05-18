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
        
        stage('Apply Ansible Playbook') {
             steps {
  
                sshagent(['ssh-remote-machine']) {
                     sh "ansible-playbook -i inventory.ini playbook.yml"

                }
            }
        }
    }
    
}
