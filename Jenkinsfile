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
    stage('Validate') {
      agent {
        docker {
          reuseNode true
          image 'bootswithdefer/terragrunt'
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
          image 'bootswithdefer/terragrunt'
          args '-e TF_IN_AUTOMATION=true'
        }
      }
      steps {
        script {
          statusCode = terraformPlan()
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
        stage('Apply Control-M NP') {
          agent {
            docker {
              reuseNode true
              image 'bootswithdefer/terragrunt'
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
            terraformApply()
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
