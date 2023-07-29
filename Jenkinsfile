pipeline {
    agent any

    environment {
        // Define environment variables for AWS ECR
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REPO = '812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo'
        DOCKER_IMAGE_NAME = 'project'
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
                    // Step 1: Build the Docker image and tag it with the unique tag
                    sh "docker build -t $DOCKER_IMAGE_NAME ."
                    sh "docker tag $DOCKER_IMAGE_NAME $ECR_REPO:$DOCKER_IMAGE_TAG"
                    // Step 2: run Docker Compose
                    sh "docker-compose up -d"
                    // Step 3: Log in to your ECR registry
                    sh "aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REPO"
                    // Step 4: Push the Docker image to ECR then remove the image
                    sh "docker push $ECR_REPO:$DOCKER_IMAGE_TAG"
                    // sh "docker rmi $ECR_REPO:$DOCKER_IMAGE_TAG"
                    // Step 5: Create Configmap
                    sh "aws eks --region $AWS_DEFAULT_REGION describe-cluster --name sprints-eks-cluster --query cluster.status"
                    sh "aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name sprints-eks-cluster"
                    // sh "kubectl create configmap ecr-image-config --from-literal=ecr_image_tag=${DOCKER_IMAGE_TAG}"
                    // sh "kubectl create configmap terraform-public-ip-config --from-literal=terraform_public_ip=${IP_HOST}"

                    // Step 6: Replace the ECR image tag in the deployment.yaml file
                    sh "sed -i 's|<ECR_IMAGE_TAG>|${DOCKER_IMAGE_TAG}|g' Kubernets_Files/deployment.yaml"

                    // Step 7: Apply the modified Kubernetes files
                    sh "kubectl apply -f Kubernets_Files/deployment.yaml -n default"
                    sh "kubectl apply -f Kubernets_Files/services.yaml -n default"
                    sh "kubectl apply -f Kubernets_Files/configmap-and-secrets.yaml -n default"
                    sh "kubectl apply -f Kubernets_Files/mysql-pv.yaml -n default"
                    sh "kubectl apply -f Kubernets_Files/mysql-pvc.yaml -n default"
                    sh "kubectl apply -f Kubernets_Files/mysql-statefulset.yaml -n default"
                    sh "kubectl apply -f Kubernets_Files/ingress.yaml -n default"
                }
            }
        }
    }

    post {
        always {
            sh "docker-compose down"
            script {
                // Get Ingress IP address
                script {
                    def serviceName = 'flask-app-service' // Replace 'your-service-name' with the name of your Kubernetes service
                    def namespace = 'default' // Replace 'your-namespace' with the namespace where the service is deployed
                    def url = sh(script: "kubectl get svc ${serviceName} -n ${namespace} -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'", returnStdout: true).trim()
                    echo "Website URL: http://${url}"
                }
            }
        }
    }
}
