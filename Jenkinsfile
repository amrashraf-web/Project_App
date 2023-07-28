pipeline {
  agent any
  environment {
    DOCKER_COMPOSE_FILE = 'docker-compose.yml'
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build Docker Image') {
      steps {
        sh "docker-compose -f $DOCKER_COMPOSE_FILE up -d"
        sh 'docker build -t amora .'
      }
    }
    stage('Push to ECR') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws_key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 812428914503.dkr.ecr.us-east-1.amazonaws.com'
          sh 'docker tag amora:${BUILD_NUMBER} 812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo:${BUILD_NUMBER}'
          sh 'docker push 812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo:${BUILD_NUMBER}'
        }
      }
    }
  }
  post {
    always {
      echo 'The website is deployed at: http://3.239.79.183:5000'
    }
  }
}
