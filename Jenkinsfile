pipeline {
  agent any
  environment {
    AWS_ACCESS_KEY_ID = credentials('AKIA32KEJN5DQYJFXVQN')
    AWS_SECRET_ACCESS_KEY = credentials('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')
  }
  stages {
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t amora .'
      }
    }

    stage('Push to ECR') {
      steps {
        withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
          sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 812428914503.dkr.ecr.us-east-1.amazonaws.com'
          sh 'docker tag amora:latest 812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo:latest'
          sh 'docker push 812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo:latest'
        }
      }
    }

    // stage('Deploy to Kubernetes') {
    //   steps {
    //     // Add your Kubernetes deployment script here to deploy the image
    //   }
    // }
  }

  post {
    always {
      echo 'The website is deployed at: http://your-website-url'
    }
  }
}
