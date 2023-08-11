pipeline {
    agent any

    environment {
        ECR_REPO = '812428914503.dkr.ecr.us-east-1.amazonaws.com/flask-app-repo' // Use the ECR repository
        DOCKER_IMAGE_NAME = 'project' // Docker image tag name (must be lower case)
        DOCKER_IMAGE_TAG = "v${BUILD_NUMBER}" // Use the build number as the Docker image tag
        CONFIGMAP_NAME = 'mysql-init-scripts'
        NAMESPACE = 'default'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    def gitCredentialsId = 'github_key' // Replace with your actual credentials ID
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/**']], // Here Mean Working On All Branches
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
                script {
                    withCredentials([usernamePassword(credentialsId: 'aws_key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]){
                        // Step 1 : Update Kube Config For Jenkins
                        sh "aws eks --region us-east-1 update-kubeconfig --name sprints-eks-cluster"
                        // Step 2: Apply the modified Kubernetes files with replaced image tag and repo
                        sh "sed -i 's|<ECR_REPO_IMAGE>|${ECR_REPO}:${DOCKER_IMAGE_TAG}|g' Kubernets_Files/deployment.yaml"
                        
                        // Check if the ConfigMap exists
                        def configmapStatus = sh(
                            script: "kubectl get configmap $CONFIGMAP_NAME -n $NAMESPACE",
                            returnStdout: true
                        ).trim()
        
                        if (configmapStatus.contains('NotFound')) {
                            // ConfigMap does not exist
                            echo "ConfigMap $CONFIGMAP_NAME does not exist."
                        } else {
                            // ConfigMap exists, so delete it
                            sh "kubectl delete configmap $CONFIGMAP_NAME -n $NAMESPACE"
                            echo "Deleted existing ConfigMap: $CONFIGMAP_NAME"
                        }
        
                        // Create the new ConfigMap
                        sh "kubectl create configmap $CONFIGMAP_NAME --from-file=BucketList.sql=/var/lib/jenkins/workspace/MyProject/MySQL-and-Python/MySQL_Queries/BucketList.sql -n $NAMESPACE"
                        echo "Created new ConfigMap: $CONFIGMAP_NAME"
                        
                        // Apply The Kubernetes Manifests
                        sh "kubectl apply -f Kubernets_Files/"
                    }
                }
            }
        }
    }

    post {
        success {
            script {
                // Step 1: Sleep 15 Sec Till All Pods Be Runnig
                sleep 15
                // Step 2: Get Ingress IP address
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
