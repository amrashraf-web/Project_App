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
                // Step 1: Checkout the code from the GitHub repository
                checkout scm
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
                sh "aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REPO"
                // Step 2: Push the Docker image to ECR
                sh "docker push $ECR_REPO:$DOCKER_IMAGE_TAG"
            }
        }

        stage('Remove Local Image') {
            steps {
                // Step 1: Remove the Docker image from the local system
                sh "docker rmi $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"
                sh "docker rmi $ECR_REPO:$DOCKER_IMAGE_TAG"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Step 1 : Update Kube Config
                sh "aws eks --region us-east-1 update-kubeconfig --name sprints-eks-cluster"
                // Step 2: Apply the modified Kubernetes files with replaced image tag and repo
                sh "sed -i 's|<ECR_REPO_IMAGE>|$ECR_REPO:${DOCKER_IMAGE_TAG}|g' Kubernets_Files/deployment.yaml"
                sh "kubectl apply -f Kubernets_Files/configmap-and-secrets.yaml"
                sh "kubectl apply -f Kubernets_Files/mysql-pv.yaml"
                sh "kubectl apply -f Kubernets_Files/mysql-pvc.yaml"
                sh "kubectl apply -f Kubernets_Files/deployment.yaml"
                sh "kubectl apply -f Kubernets_Files/services.yaml"
                sh "kubectl apply -f Kubernets_Files/mysql-statefulset.yaml"
                sh "kubectl apply -f Kubernets_Files/ingress.yaml"
            }
        }
    }

    post {
        always {
            // Step 1: Docker Compose Down
            sh "docker-compose down"
            script {
                // Step 8: Get Ingress IP address
                def serviceName = 'flask-app-service' // Replace 'flask-app-service' with the name of your Kubernetes service
                def url = sh(script: "kubectl get svc ${serviceName} -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'", returnStdout: true).trim()
                echo "Website URL: http://${url}"
            }
        }
    }
}
