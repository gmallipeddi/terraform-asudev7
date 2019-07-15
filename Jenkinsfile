#!groovy
def statusCode
pipeline {
  agent {
    label 'ec2-docker'
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '20'))
  }
  triggers {
    pollSCM('H * * * *') //runs this pipeline on every commit
    cron('H H * * *') //run once per day
  }
  stages {
    stage('Validate shared') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.11'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        terraformInit('terraform-shared')
      }
    }
    stage('Plan shared') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.11'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        script {
          statusCode = terraformPlan('terraform-shared')
        }
      }
    }
    stage('Gate for changes shared') {
      when {
        beforeAgent true
        branch 'master'
        expression {
          statusCode == 2
        }
      }
      parallel {
        stage('Apply') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.11'
              args '-e TF_IN_AUTOMATION=true'
            }
          }
          options {
            timeout(time: 60, unit: 'MINUTES')
          }
          input {
            message "Should we continue?"
            ok "Yes, we should."
          }
          steps {
            script {
              terraformApply('terraform-shared')
            }
          }
        }
      }
    }
    stage('Validate account') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.11'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        terraformInit('terraform-acct')
      }
    }
    stage('Plan account') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.11'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        script {
          statusCode = terraformPlan('terraform-acct', 'nonprod')
        }
      }
    }
    stage('Gate for changes account') {
      when {
        beforeAgent true
        branch 'master'
        expression {
          statusCode == 2
        }
      }
      parallel {
        stage('Apply') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.11'
              args '-e TF_IN_AUTOMATION=true'
            }
          }
          options {
            timeout(time: 60, unit: 'MINUTES')
          }
          input {
            message "Should we continue?"
            ok "Yes, we should."
          }
          steps {
            script {
              terraformApply('terraform-acct', 'nonprod')
            }
          }
        }
      }
    }
    stage('Validate') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.11'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        terraformInit()
      }
    }
    stage('Plan') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.11'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        script {
          def vault_addr = 'https://ops-vault-prod.opsprod.asu.edu'
          def vault_token = vaultLogin(vault_addr, 'ops-vault-jenkins')
          statusCode = terraformPlan('terraform', 'asupmtst', "-var vault_addr=${vault_addr} -var vault_token=${vault_token}")
        }
      }
    }
    stage('Gate for changes') {
      when {
        beforeAgent true
        branch 'master'
        expression {
          statusCode == 2
        }
      }
      parallel {
        stage('Apply') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.11'
              args '-e TF_IN_AUTOMATION=true'
            }
          }
          options {
            timeout(time: 60, unit: 'MINUTES')
          }
          input {
            message "Should we continue?"
            ok "Yes, we should."
          }
          steps {
            script {
              def vault_addr = 'https://ops-vault-prod.opsprod.asu.edu'
              def vault_token = vaultLogin(vault_addr, 'ops-vault-jenkins')
              terraformApply('terraform', 'asupmtst', "-var vault_addr=${vault_addr} -var vault_token=${vault_token}")
            }
          }
        }
      }
    }
  }
  post {
    always {
      slackNotification('#prdfam-edw-ci')
      clean()
    }
  }
}
