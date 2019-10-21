#!groovy
def statusCode
def performASUPMSUPapplyStage = 'true'
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
          image 'bootswithdefer/terragrunt:0.12'
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
          image 'bootswithdefer/terragrunt:0.12'
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
        stage('Apply shared') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.12'
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
          image 'bootswithdefer/terragrunt:0.12'
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
          image 'bootswithdefer/terragrunt:0.12'
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
        stage('Apply account') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.12'
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
    stage('Plan prod account') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        script {
          statusCode = terraformPlan('terraform-acct', 'prod')
        }
      }
    }
    stage('Gate for changes prod account') {
      when {
        beforeAgent true
        branch 'master'
        expression {
          statusCode == 2
        }
      }
      parallel {
        stage('Apply account') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.12'
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
              terraformApply('terraform-acct', 'prod')
            }
          }
        }
      }
    }
    stage('Validate asupmcld') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        terraformInit('terraform-asupmcld')
      }
    }
    stage('Plan asupmcld') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        script {
          def vault_addr = 'https://ops-vault-prod.opsprod.asu.edu'
          def vault_token = vaultLogin(vault_addr, 'ops-vault-jenkins')
          statusCode = terraformPlan('terraform-asupmcld', 'asupmcld', "-var vault_addr=${vault_addr} -var vault_token=${vault_token}")
        }
      }
    }
    stage('Gate for changes asupmcld') {
      when {
        beforeAgent true
        branch 'master'
        expression {
          statusCode == 2
        }
      }
      parallel {
        stage('Apply asupmcld') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.12'
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
              terraformApply('terraform-asupmcld', 'asupmcld', "-var vault_addr=${vault_addr} -var vault_token=${vault_token}")
            }
          }
        }
      }
    }
    stage('Validate asupmsup') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        terraformInit('terraform-asupmsup')
      }
    }
    stage('Plan asupmsup') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        ansiColor('xterm') {
          script {
            def vault_addr = 'https://ops-vault-prod.opsprod.asu.edu'
            def vault_token = vaultLogin(vault_addr, 'ops-vault-jenkins')
            def subdir = 'terraform-asupmsup'
            def workspace = 'asupmsup'
            def extra_args = "-destroy -var vault_addr=${vault_addr} -var vault_token=${vault_token}"
            sh "cd ${subdir} && (terraform workspace select ${workspace} || terraform workspace new ${workspace})"
            echo "Executing (with extra args redacted): terraform plan -var-file=${workspace}.tfvars -detailed-exitcode -no-color -input=false"
            statusCode = sh(
                returnStatus: true,
                script: "cd ${subdir} && set +x -u -o pipefail && terraform plan -var-file=${workspace}.tfvars ${extra_args} -detailed-exitcode -no-color -input=false 2>&1 | tee plan.out")
            sh "grep -v Refreshing ${subdir}/plan.out > ${subdir}/plan.out.clean"
            planOutput = readFile "${subdir}/plan.out.clean"
          }
        }
      }
    }
    stage('Gate for changes asupmsup') {
      when {
        beforeAgent true
        branch 'master'
        expression {
          statusCode == 2
        }
        expression {
          performASUPMSUPapplyStage == "true"
        }
      }
      parallel {
        stage('Apply asupmsup') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.12'
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
            ansiColor('xterm') {
              script {
                def vault_addr = 'https://ops-vault-prod.opsprod.asu.edu'
                def vault_token = vaultLogin(vault_addr, 'ops-vault-jenkins')
                def subdir = 'terraform-asupmsup'
                def workspace = 'asupmsup'
                def extra_args = "-var vault_addr=${vault_addr} -var vault_token=${vault_token}"
                sh "cd ${subdir} && (terraform workspace select ${workspace} || terraform workspace new ${workspace})"
                echo "Executing (with extra args redacted): terraform destroy -var-file=${workspace}.tfvars -auto-approve"
                sh "cd ${subdir} && set +x -u -o pipefail && terraform destroy -var-file=${workspace}.tfvars ${extra_args} -auto-approve"
              }
            }
          }
        }
      }
    }
    stage('Validate asupmtst') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        terraformInit()
      }
    }
    stage('Plan asupmtst') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
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
    stage('Gate for changes asupmtst') {
      when {
        beforeAgent true
        branch 'master'
        expression {
          statusCode == 2
        }
      }
      parallel {
        stage('Apply asupmtst') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.12'
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
    stage('Validate asupmprd') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        terraformInit('terraform-asupmprd')
      }
    }
    stage('Plan asupmprd') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt:0.12'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        script {
          def vault_addr = 'https://ops-vault-prod.opsprod.asu.edu'
          def vault_token = vaultLogin(vault_addr, 'ops-vault-jenkins')
          statusCode = terraformPlan('terraform-asupmprd', 'asupmprd', "-var vault_addr=${vault_addr} -var vault_token=${vault_token}")
        }
      }
    }
    stage('Gate for changes asupmprd') {
      when {
        beforeAgent true
        branch 'master'
        expression {
          statusCode == 2
        }
      }
      parallel {
        stage('Apply asupmprd') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt:0.12'
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
              terraformApply('terraform-asupmprd', 'asupmprd', "-var vault_addr=${vault_addr} -var vault_token=${vault_token}")
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
