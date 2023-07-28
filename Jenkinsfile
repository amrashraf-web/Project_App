pipeline {
    agent any

    environment {
        // Define environment variables for AWS ECR
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REPO = '812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo'
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
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
                // Step 3: Build and run Docker Compose
                script {
                    sh "docker-compose -f $DOCKER_COMPOSE_FILE up -d"
                }

                // Step 4: Log in to your ECR registry
                script {
                    sh "aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REPO"
                }

                // Step 5: Build the Docker image and tag it
                script {
                    sh "docker tag project-web:latest $ECR_REPO/project-web:latest"
                }

                // Step 6: Push the Docker image to ECR
                script {
                    withEnv(["DOCKER_DEBUG=1"]) {
                        sh "docker push $ECR_REPO/project-web:latest"
                    }
                }
            }
        }

        // Additional stages for testing, linting, etc. can be added as needed
    }
}
