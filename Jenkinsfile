pipeline {
 agent any

environment {
    DOCKERHUB_CREDENTIALS = credentials('joeltosin-dockerhub')
  }
 stages {

    stage("Initial cleanup") {
          steps {
              dir("${WORKSPACE}") {
              deleteDir()
              }
          }
    }

    stage ('Checkout SCM') 
    {
       steps {
         git branch: 'main', url: "https://github.com/jtoguntoye/docker-php-todo.git"
         }
    }

    stage ('Build docker image') 
      {
       steps {
         sh "docker build -t joeltosin/todo-app:${env.BRANCH_NAME}-${env.BUILD_NUMBER} ."
        }
    }
    stage ('Start the app')
    {
      steps {
        sh "docker-compose up -d"
      }
    }

    stage ('Test the endpoint and push image to dockerhub if sucessful')
    {
      steps {
        script{
          while (true) {
            def response = httpRequest 'http://localhost:8200'
            if(response == 200) {
              sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
              sh "docker push joeltosin/todo-app:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
            }
            break
          }
        }

      }
    }

} 
    post 
  {
    always {
      sh "docker-compose down"
      sh "docker system prune -af"
      sh 'docker logout'
    }
  }
}
