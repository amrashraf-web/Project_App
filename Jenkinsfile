pipeline {
    agent any

    environment {
        // Define environment variables for AWS ECR
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REPO = 'public.ecr.aws/j5h9z7a9/amora'
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
    }

    stages {
        stage('Checkout') {
            steps {
                // Step 1: Checkout the code from the GitHub repository
                checkout scm
            }
        }

        stage('Get Image Name') {
            steps {
                // Step 2: Extract the image name from the docker-compose.yml file
                script {
                    IMAGE_NAME = sh(returnStdout: true, script: "grep 'image:' $DOCKER_COMPOSE_FILE | awk '{print \$2}'").trim()
                }
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
                    sh "docker tag $IMAGE_NAME $ECR_REPO/$IMAGE_NAME"
                }

                // Step 6: Push the Docker image to ECR
                script {
                    sh "DOCKER_DEBUG=1 docker push $ECR_REPO/$IMAGE_NAME"
                }
            }
        }

        // Additional stages for testing, linting, etc. can be added as needed
    }
}
