<div align="center">
  <h1 style="color: red;"> :heart_on_fire: Sprints Graduation Project</h1>
</div>

<div align="center">
  <h1 style="color: green;"> :right_anger_bubble: Deploying Flask Application Using ( K8s - Jenkins )</h1>
</div>

<div align="center">
  <h1 style="color: yellow;"> :cowboy_hat_face: Introduction</h1>
  <h2>Welcome to the comprehensive guide on deploying a Flask application using Kubernetes (K8s) and Jenkins. This guide is designed to take you through every step necessary to successfully set up, automate, and deploy your Flask application, streamlining your development workflow and ensuring a smooth deployment process. Whether you're new to the world of deployment or looking to enhance your existing knowledge, this guide has got you covered.</h2>
</div>

<div align="center">
  <h1 style="color: green;"> :sunglasses: Explanation</h1>
  <h2>In this guide, we've outlined a detailed roadmap to guide you through each stage of deploying a Flask application using Kubernetes and Jenkins. We've broken down the process into several key sections</h2>
  
  <p>Ansible: Is automation tool that allows you to manage and configure systems in a declarative manner. It has a simple syntax, is agentless, and can automate complex tasks across different systems. Ansible ensures consistent configurations, reduces manual error, and improves efficiency in managing infrastructure and application deployments.</p>
  
<p>Terraform: Terraform is an infrastructure as code (IaC) tool that enables you to define and manage your infrastructure in a version-controlled and repeatable way. It supports multiple cloud providers and ensures consistent infrastructure deployments. Terraform's code-based approach makes it easy to understand and collaborate on infrastructure changes, improving maintainability and reducing manual setup time.</p>

<p>Docker: Docker is a containerization platform that allows you to package applications and their dependencies into isolated containers. Containers ensure consistency between development and production environments, making it easier to deploy and scale applications. Docker simplifies deployment, reduces conflicts between dependencies, and promotes microservices architecture</p>
  
<p>Docker Compose: Docker Compose is a tool for defining and running multi-container Docker applications using a single configuration file. It simplifies the process of managing complex applications by allowing you to define the relationships between different services and spin them up together. Docker Compose streamlines development and testing workflows, making it easier to replicate environments across different machines.</p>
  
<p>Jenkins: Jenkins is a widely-used open-source automation server that helps automate the building, testing, and deployment of software projects. It supports continuous integration and continuous delivery (CI/CD) pipelines, enabling efficient and reliable software releases. Jenkins integrates with various tools and services, enhancing collaboration and automation across the development lifecycle.</p>
  
<p>Kubernetes: Kubernetes is an orchestration platform for containerized applications. It automates deployment, scaling, and management of application containers. Kubernetes abstracts away the underlying infrastructure, making it easier to manage applications across different environments. It enhances application availability, scalability, and resilience.</p>
  
<p>Amazon EKS: Amazon EKS is a managed Kubernetes service provided by AWS. It simplifies the deployment and management of Kubernetes clusters, allowing you to focus on your applications rather than managing the underlying infrastructure. EKS provides security, scalability, and reliability for your containerized applications</p>
  
<p>Amazon ECR: Amazon ECR is a managed Docker container registry provided by AWS. It allows you to store, manage, and deploy Docker container images. ECR integrates seamlessly with other AWS services, making it easy to build and deploy containers in your AWS environment. ECR ensures secure storage, distribution, and versioning of container images.</p>
</div>

  [![Up to Date](https://github.com/ikatyang/emoji-cheat-sheet/workflows/Up%20to%20Date/badge.svg)](https://github.com/amrashraf-web/Project_App/actions)
## Table of Contents
- [1. Prerequisites](#1-prerequisites)
  - [1.1 GitHub Account and Token](#11-github-account-and-token)
  - [1.2 AWS Account and Access-Secret Key](#12-aws-account-and-access-secret-key)
  - [1.3 AWS Key Pair](#13-aws-key-pair)
  - [1.4 Ubuntu Machine](#14-ubuntu-machine)
- [2. Install Dependencies and Prepare Infrastructure](#2-install-dependencies-and-prepare-infrastructure)
  - [2.1 Clone the Project](#21-clone-the-project)
  - [2.2 Install Terraform and Ansible](#22-install-terraform-and-ansible)
- [3. Automate Infrastructure and Dependencies](#3-automate-infrastructure-and-dependencies)
  - [3.1 Prepare Infrastructure](#31-prepare-infrastructure)
  - [3.2 Replace Private Key in Ansible](#32-replace-private-key-in-ansible)
  - [3.3 Run Deployment Script](#33-run-deployment-script)
  - [3.4 OutPut Terraform Ansible Image](#34-OutPut-Terraform-Ansible-Image)
- [4. Update Jenkins with Dependencies](#4-update-jenkins-with-dependencies)
  - [4.1 Access Jenkins](#41-access-jenkins)
  - [4.2 Add GitHub and AWS Keys](#42-add-github-and-aws-keys)
- [5. Create Deployment Pipeline](#5-create-deployment-pipeline)
  - [5.1 Create a Webhook in Github](#51-Create-a-Webhook-in-Github)
  - [5.2 Configure Jenkins Job](#52-configure-jenkins-job)
- [6. Check Pods and Nodes](#6-check-pods-and-nodes)
- [7. Test Project and Database](#7-test-project-and-database)
- [8. Test Locally with Docker-compose](#8-test-locally-with-docker-compose)


## 1. Prerequisites
<details>
<summary>### 1.1 GitHub Account and Token</summary><br><b>

1. **Login to GitHub**: Log in to your GitHub account.
2. **Access Personal Access Tokens**: Go to your GitHub settings. Click on your profile picture in the top right corner, then select "Settings".
3. **Access Developer Settings**: In the left sidebar, under "Developer settings", click on "Personal access tokens".
4. **Generate New Token**: Click the "Generate new token Classic" button.
5. **Configure Token Permissions**: Give your token a meaningful name and select the necessary permissions. Be cautious not to grant more permissions than necessary.
6. **Select Scopes**: GitHub offers various scopes for different permissions. Choose the ones that align with your requirements.
7. **Generate Token**: After configuring permissions, click the "Generate token" button at the bottom of the page.
8. **Copy Token**: GitHub will generate a token for you. Copy this token and store it securely.
   
</b></details>
### 1.2 AWS Account and Access-Secret Key

1. **Login to AWS Console**: Log in to your AWS Management Console.
2. **Access IAM**: Go to the "Identity and Access Management (IAM)" service.
3. **Access Users**: In the IAM dashboard, select "Users" from the left sidebar.
4. **Add User**: Click the "Add user" button.
5. **User Details**: Provide a username for the new user. Select "Programmatic access" to generate access keys for API interactions.
6. **Set Permissions**: Choose between adding the user to a group with necessary permissions or attaching policies directly to the user.
7. **Generate Access Key**: After creating the user, generate an access key.
8. **Copy Token**: AWS will generate an access-secret key pair. Copy these keys and store them securely.

### 1.3 AWS Key Pair

1. **Login to AWS Console**: Log in to your AWS Management Console.
2. **Access EC2 Dashboard**: Go to the "EC2 Dashboard" from the services menu.
3. **Key Pairs**: In the EC2 dashboard, select "Key Pairs" from the left sidebar under the "Network & Security" section.
4. **Create Key Pair**: Click the "Create Key Pair" button.
5. **Key Pair Name**: Give your key pair a name. Choose "pem" format to generate a .pem file containing your private key.
6. **Create Key Pair**: Click the "Create Key Pair" button.
7. **Download Key Pair**: After creating the key pair, the private key will be automatically downloaded.

### 1.4 Ubuntu Machine
  Ensure you have access to an Ubuntu machine.

## 2. Install Dependencies and Prepare Infrastructure

### 2.1 Clone the Project
  1. **Clone Project**: Clone this project into your home directory with the provided command.
     ```
     cd ~
     git clone https://github.com/amrashraf-web/Project_App
     ```

### 2.2 Install Terraform and Ansible

  1. **Install Dependencies**: Navigate to the project folder and install Terraform and Ansible.
     ```
     cd ~/Project_App
     chmod +x Install_Terrafrom_Ansible.sh
     ./Install_Terrafrom_Ansible.sh
     ```



## 3. Automate Infrastructure and Dependencies

### 3.1 Prepare Infrastructure
  1. Configure Your Access-Secret key And Key Pair Name in Terraform and update necessary information.
     - ### Put Your Aws Access - Secret Key - Key Pair Name in file [values.auto.tfvars](https://github.com/amrashraf-web/Project_App/blob/master/Terraform_Files/values.auto.tfvars)
     
### 3.2 Replace Private Key in Ansible
1. **Replace Private Key**: Replace your private key pair in Ansible configuration.
     - ### Put Your Aws Key Pair File (.pem) In This Folder [Ansible_Files](https://github.com/amrashraf-web/Project_App/blob/master/Ansible_Files)
       
     - ### Replace You Aws Key Pair in ansible_ssh_private_key_file in this file [inventory.ini](https://github.com/amrashraf-web/Project_App/blob/master/Ansible_Files/inventory.ini)

    - ### Put Your Your Access-Secret key In This File [main.yml](https://github.com/amrashraf-web/Project_App/blob/master/Ansible_Files/roles/Install_Aws/vars/main.yml)
      
### 3.3 **Run Deployment Script**
1. Navigate to the project folder and run the deployment script.
   ```
   cd ~/Project_App
   chmod +x Deploy.sh
   ./Deploy.sh
   ```
### 3.4 **OutPut Terraform Ansible Image**
  - Here Output Of Terraform Image
   
    ![image](https://github.com/amrashraf-web/Project_App/assets/82893114/6e762903-e52d-418b-8403-b4acb4d41fa1)

  - Here Output Of Ansible Image
   
    ![image](https://github.com/amrashraf-web/Project_App/assets/82893114/ad14539a-49d6-4d2d-87de-294942164a75)



## 4. Update Jenkins with Dependencies

### 4.1 Access Jenkins
1. **Access Jenkins**: Access Jenkins using the provided URL in Last Image Mentioned Above and login with The Admin API token.
2. **Install Plugins**: Click "Install suggested plugins" and wait for the installation to finish.
3. **Create User**: Create a user with necessary information.
4. **Start Jenkins**: Click "Start Jenkins".

### 4.2 Add GitHub and AWS Keys
1. **Add GitHub and AWS Keys**:

   - GitHub Key:
     - Go to Manage Jenkins > Credentials > System > Global credentials (unrestricted) > Add credentials.
     - Use Username with password, scope Global.
     - Provide your GitHub username in username field and token in password field.
     - ID: github_key

   - AWS Key:
     - Go to Manage Jenkins > Credentials > System > Global credentials (unrestricted) > Add credentials.
     - Use Username with password, scope Global.
     - Provide your AWS Access Key in username field and Secret Key in password field.
     - ID: aws_key


## 5. Create Deployment Pipeline

### 5.1 Create a Webhook in Github
1. Create a Webhook:

  - Go to your GitHub repository.
  - Click on "Settings" tab.
  - Click on "Webhooks" in the left sidebar.
  - Click the "Add webhook" button.

2. Configure the Webhook:

  - Payload URL: This is the URL of your Jenkins server's webhook endpoint. It usually looks like http://ip_server:8080/github-webhook/.
  - Content type: Set it to application/json.
  - Which events would you like to trigger this webhook?: Choose the events that should trigger the Jenkins build. Typically, you might select "Push events" for any code pushes to the repository.

  - Click the "Add webhook" button to save your webhook configuration.

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/1f37f386-6247-4e92-9224-34519dbf1dd9)

### 5.2 Configure Jenkins Job
  1. - In Jenkins Page Click Create Job 
  2. - In Enter an item name Field Put Any Name For Pipeline
  3. - Choose Pipeline
  4. - Click Ok
  5. - in The Configure Page 
      - Check True For This Option : GitHub hook trigger for GITScm polling In Build Triggers
      - In Pipeline Choose Pipeline Script And Put Your Jenkins Code
        
         > [!IMPORTANT]
         > 
         > Make Sure That You Replaced My ECR repository with your ECR repository in JenkinsFile Code Line 5 [jenkinsfile](https://github.com/amrashraf-web/Project_App/blob/master/Jenkinsfile)
         
      - Click Save 
      - Now Click Build

## 6. Check Pods and Nodes

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/27be02d4-2874-495a-95a7-733afd2bb70c)


## 7. Test Project and Database

1. ![image](https://github.com/amrashraf-web/Project_App/assets/82893114/37a88674-401f-455d-a502-d483f51c5d20)

2. ![image](https://github.com/amrashraf-web/Project_App/assets/82893114/0cef5dc9-693d-4fb0-959a-f075211a3b90)

3. ![image](https://github.com/amrashraf-web/Project_App/assets/82893114/9ad65d47-ef50-4444-8f5b-51312b8d7130)


## 8. Test Locally with Docker-compose

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/b0420d91-571b-4280-8ed9-94cbe11edbd0)


<div align="center">
  <h1 style="color: yellow;"> :100: Conclusion</h1>
  <h2>Deploying a Flask application using Kubernetes and Jenkins can seem complex, but with this guide, you now have a clear roadmap to follow. By carefully following each step, you'll establish a robust deployment process that streamlines your workflow and ensures the successful deployment of your projects. Remember, practice makes perfect, so don't hesitate to experiment and adapt the process to your specific needs. Congratulations on taking this significant step toward enhancing your development and deployment skills!</h2>
</div>
