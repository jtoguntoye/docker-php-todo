pipeline {
 agent any

environment {
    DOCKERHUB_CREDENTIALS = credentials('joel-dockerhub')
  }
 stages {

    stage ('initial cleanup') {
         steps {
             dir ("${WORKSPACE}") {
                 deleteDir()
             }
         }
    }

    stage ('Checkout SCM') {
         steps {
             git branch: 'main', url: "https://github.com/jtoguntoye/docker-php-todo.git"
         }
    }

    stage ('Build docker image') {
        steps {
             sh 'docker build -t joeltosin/todo-app:${env.BRANCH_NAME}-${env.BUILD_NUMBER} . '
        }
    }

    stage ('Login to Docker hub') {

        steps {
              sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        
        }  
    }
    stage ('Docker push') {
        steps {
            sh 'docker push joeltosin/todo-app:${env.BRANCH_NAME}-${env.BUILD_NUMBER}'
        }
    }
  }
  post 
  {
    always {
      sh 'docker logout'
    }
  }

}