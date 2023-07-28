pipeline {
    agent any

    environment {
        // Define environment variables for AWS ECR
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REPO = '812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo'
        DOCKER_IMAGE_NAME = 'latest'
        DOCKER_IMAGE_TAG = "v${BUILD_NUMBER}" // Use the build number as the Docker image tag
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
        IP_Host = '3.239.79.183'
    }

    stages {
        stage('Checkout') {
            steps {
                // Step 1: Checkout the code from the GitHub repository
                checkout scm
            }
        }

        stage('Build and Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws_key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]){
                    // Step 2: Build and run Docker Compose (if applicable)
                    sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d'
                    // Step 3: Log in to your ECR registry
                    sh 'aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REPO'
                    // Step 4: Build the Docker image and tag it with the unique tag
                    sh "docker build -t $ECR_REPO/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG ."
                    // Step 5: Push the Docker image to ECR
                    sh "docker push $ECR_REPO/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"
                }
            }
        }
    }

    post {
        always {
            echo 'The website is deployed at: http://$IP_Host:5000'
        }
    }
}
