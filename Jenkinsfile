pipeline {
    agent any

    environment {
        ECR_REPO = '812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo' // Use the ECR repository
        DOCKER_IMAGE_NAME = 'project' // Docker image tag name (must be lower case)
        DOCKER_IMAGE_TAG = "v${BUILD_NUMBER}" // Use the build number as the Docker image tag
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    def gitCredentialsId = 'github_key' // Replace with your actual credentials ID
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/master']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/amrashraf-web/Project_App', // Replace with your actual project
                            credentialsId: gitCredentialsId
                        ]]
                    ])
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                // Step 1: Build the Docker image and tag it any tag name 
                sh "docker build -t $DOCKER_IMAGE_NAME ."
                sh "docker tag $DOCKER_IMAGE_NAME $ECR_REPO:$DOCKER_IMAGE_TAG"
            }
        }
        
        stage('Push to ECR') {
            steps {
                // Step 1: Log in to your ECR registry
                sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPO"
                // Step 2: Push the Docker image to ECR
                sh "docker push $ECR_REPO:$DOCKER_IMAGE_TAG"
            }
        }

        stage('Remove Local Image') {
            steps {
                // Step 1: Remove the Docker image from the local system
                sh "docker rmi $DOCKER_IMAGE_NAME"
                sh "docker rmi $ECR_REPO:$DOCKER_IMAGE_TAG"
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws_key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]){
                    // Step 1 : Update Kube Config For Jenkins
                    sh "aws eks --region us-east-1 update-kubeconfig --name sprints-eks-cluster"
                    // Step 2: Apply the modified Kubernetes files with replaced image tag and repo
                    sh "sed -i 's|<ECR_REPO_IMAGE>|$ECR_REPO:${DOCKER_IMAGE_TAG}|g' Kubernets_Files/deployment.yaml"
                    sh "kubectl apply -f Kubernets_Files/"
                }
            }
        }
    }

    post {
        success {
            // Step 1: Get Ingress IP address
            script {
                def serviceName = 'flask-app-service' // Replace 'flask-app-service' with the name of your Kubernetes App service
                def url = sh(script: "kubectl get svc ${serviceName} -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'", returnStdout: true).trim()
                echo "Website URL: http://${url}"
            }
        }
        failure {
            echo "Build Failed. Please Check The Build Logs To Fix The Error."
        }
    }
}
