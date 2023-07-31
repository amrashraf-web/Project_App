pipeline {
    agent any

    environment {
        // Define environment variables for AWS ECR
        AWS_DEFAULT_REGION = 'us-east-1' // Use the region
        ECR_REPO = '812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo' // Use the ecr repository
        DOCKER_IMAGE_NAME = 'project' // Docker image tag name ( must be lower case )
        DOCKER_IMAGE_TAG = "v${BUILD_NUMBER}" // Use the build number as the Docker image tag
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
                    // Step 1: Build the Docker image and tag it any tag name 
                    sh "docker build -t $DOCKER_IMAGE_NAME ."
                    sh "docker tag $DOCKER_IMAGE_NAME $ECR_REPO:$DOCKER_IMAGE_TAG"
                    // Step 2: run Docker Compose
                    sh "docker-compose up -d"
                    // Step 3: Log in to your ECR registry
                    sh "aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REPO"
                    // Step 4: Push the Docker image to ECR
                    sh "docker push $ECR_REPO:$DOCKER_IMAGE_TAG"
                    // Step 6: Update Kube Config
                    sh "aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name sprints-eks-cluster"
                    // step 7: Install Nginx Controller
                    script {
                        try {
                            sh "helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx"
                            sh "helm repo update"
                            sh "helm install nginx-ingress ingress-nginx/ingress-nginx"
                        } catch (Exception e) {
                            echo "Error installing Ingress-Nginx: ${e.message}"
                            error "Failed to install Ingress-Nginx"
                        }
                    }
                    // Step 8: Apply the modified Kubernetes files with replaced image tag and repo
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
    }

    post {
        always {
            // Step 9: Docker Compose Down
            sh "docker-compose down"
            script {
                // Step 10: Get Ingress IP address
                def serviceName = 'flask-app-service' // Replace 'your-service-name' with the name of your Kubernetes service
                def url = sh(script: "kubectl get svc ${serviceName} -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'", returnStdout: true).trim()
                echo "Website URL: http://${url}"
            }
        }
    }
}
