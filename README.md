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

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/3c6e7ba0-1138-433c-a5d0-df24cdcf5d1d)


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
<summary><a name="11-github-account-and-token"></a>1.1 GitHub Account and Token</summary><br><b>

1. **Login to GitHub**: Log in to your GitHub account.
2. **Access Personal Access Tokens**: Go to your GitHub settings. Click on your profile picture in the top right corner, then select "Settings".
3. **Access Developer Settings**: In the left sidebar, under "Developer settings", click on "Personal access tokens".
4. **Generate New Token**: Click the "Generate new token Classic" button.
5. **Configure Token Permissions**: Give your token a meaningful name and select the necessary permissions. Be cautious not to grant more permissions than necessary.
6. **Select Scopes**: GitHub offers various scopes for different permissions. Choose the ones that align with your requirements.
7. **Generate Token**: After configuring permissions, click the "Generate token" button at the bottom of the page.
8. **Copy Token**: GitHub will generate a token for you. Copy this token and store it securely.
   
</b></details>
<details>
<summary><a name="12-aws-account-and-access-secret-key"></a>1.2 AWS Account and Access-Secret Key</summary><br><b>

1. **Login to AWS Console**: Log in to your AWS Management Console.
2. **Access IAM**: Go to the "Identity and Access Management (IAM)" service.
3. **Access Users**: In the IAM dashboard, select "Users" from the left sidebar.
4. **Add User**: Click the "Add user" button.
5. **User Details**: Provide a username for the new user. Select "Programmatic access" to generate access keys for API interactions.
6. **Set Permissions**: Choose between adding the user to a group with necessary permissions or attaching policies directly to the user.
7. **Generate Access Key**: After creating the user, generate an access key.
8. **Copy Token**: AWS will generate an access-secret key pair. Copy these keys and store them securely.
</b></details>

<details>
<summary><a name="13-aws-key-pair"></a>1.3 AWS Key Pair</summary><br><b>
  
1. **Login to AWS Console**: Log in to your AWS Management Console.
2. **Access EC2 Dashboard**: Go to the "EC2 Dashboard" from the services menu.
3. **Key Pairs**: In the EC2 dashboard, select "Key Pairs" from the left sidebar under the "Network & Security" section.
4. **Create Key Pair**: Click the "Create Key Pair" button.
5. **Key Pair Name**: Give your key pair a name. Choose "pem" format to generate a .pem file containing your private key.
6. **Create Key Pair**: Click the "Create Key Pair" button.
7. **Download Key Pair**: After creating the key pair, the private key will be automatically downloaded.
</b></details>

<details>
<summary><a name="14-ubuntu-machine"></a>1.4 Ubuntu Machine</summary><br><b>

  Ensure you have access to an Ubuntu machine.
</b></details>

## 2. Install Dependencies and Prepare Infrastructure

<details>
<summary><a name="21-clone-the-project"></a>2.1 Clone the Project</summary><br><b>

  1. **Clone Project**: Clone this project into your home directory with the provided command.
     ```
     cd ~
     git clone https://github.com/amrashraf-web/Project_App
     ```

</b></details>

<details>

<summary><a name="22-install-terraform-and-ansible"></a>2.2 Install Terraform and Ansible</summary><br><b>

  1. **Install Dependencies**: Navigate to the project folder and install Terraform and Ansible.
     ```
     cd ~/Project_App
     chmod +x Install_Terrafrom_Ansible.sh
     ./Install_Terrafrom_Ansible.sh
     ```

</b></details>


## 3. Automate Infrastructure and Dependencies

<details>
<summary><a name="31-prepare-infrastructure"></a>3.1 Prepare Infrastructure</summary><br><b>

  1. Configure Your Access-Secret key And Key Pair Name in Terraform and update necessary information.
     - ### Put Your Aws Access - Secret Key - Key Pair Name in file [values.auto.tfvars](https://github.com/amrashraf-web/Project_App/blob/master/Terraform_Files/values.auto.tfvars)
     
</b></details>

<details>
<summary><a name="32-replace-private-key-in-ansible"></a>3.2 Replace Private Key in Ansible</summary><br><b>

1. **Replace Private Key**: Replace your private key pair in Ansible configuration.
     - ### Put Your Aws Key Pair File (.pem) In This Folder [Ansible_Files](https://github.com/amrashraf-web/Project_App/blob/master/Ansible_Files)
       
     - ### Replace You Aws Key Pair in ansible_ssh_private_key_file in this file [inventory.ini](https://github.com/amrashraf-web/Project_App/blob/master/Ansible_Files/inventory.ini)

    - ### Put Your Your Access-Secret key In This File [main.yml](https://github.com/amrashraf-web/Project_App/blob/master/Ansible_Files/roles/Install_Aws/vars/main.yml)

</b></details>

<details>
<summary><a name="33-run-deployment-script"></a>3.3 Run Deployment Script</summary><br><b>

1. Navigate to the project folder and run the deployment script.
   ```
   cd ~/Project_App
   chmod +x Deploy.sh
   ./Deploy.sh
   ```
</b></details>

<details>
<summary><a name="34-OutPut-Terraform-Ansible-Image"></a>3.4 OutPut Terraform Ansible Image</summary><br><b>

  - Here Output Of Terraform Image
   
   ![image](https://github.com/amrashraf-web/Project_App/assets/82893114/65d035da-a3a3-4842-9f3d-a9a1ecc7f7d8)

  - Here Output Of Ansible Image
   
    ![image](https://github.com/amrashraf-web/Project_App/assets/82893114/7e11fc1b-13cb-45b8-a94e-ae6102a1ab70)


</b></details>


## 4. Update Jenkins with Dependencies

<details>
<summary><a name="41-access-jenkins"></a>4.1 Access Jenkins</summary><br><b>

1. **Access Jenkins**: Access Jenkins using the provided URL in Last Image Mentioned Above and login with The Admin API token.
2. **Install Plugins**: Click "Install suggested plugins" and wait for the installation to finish.
3. **Create User**: Create a user with necessary information.
4. **Start Jenkins**: Click "Start Jenkins".

</b></details>

<details>
<summary><a name="42-add-github-and-aws-keys"></a>4.2 Add GitHub and AWS Keys</summary><br><b>

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

</b></details>

## 5. Create Deployment Pipeline

<details>
<summary><a name="51-Create-a-Webhook-in-Github"></a>5.1 Create a Webhook in Github</summary><br><b>

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

  ![image](https://github.com/amrashraf-web/Project_App/assets/82893114/b4fc47c2-96b0-4922-b156-100db67aa447)


</b></details>

<details>
<summary><a name="52-configure-jenkins-job"></a>5.2 Configure Jenkins Job</summary><br><b>

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

</b></details>

## 6. Check Pods and Nodes

<details>
<summary><a name="6-check-pods-and-nodes">6.1 Check Pods and Nodes</a></summary><br><b>

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/b5fcb2eb-3ad9-4b85-94df-a19d4114a1b5)


</b></details>

## 7. Test Project and Database

<details>
<summary><a name="7-test-project-and-database"></a>7.1 Test Project and Database</summary><br><b>


![image](https://github.com/amrashraf-web/Project_App/assets/82893114/290ba1fe-a4fd-43ef-b005-33beae855e8d)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/d6b9beec-9c47-4176-a114-947a183cadb1)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/934ec5f5-b98d-433c-9319-73101ce59f96)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/d7dc3a1b-b23b-48ca-bfc8-d39119ffbf82)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/26ae7bec-a237-4477-a8cf-4f82a1f6a0aa)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/735d4181-32d1-4592-880f-00b4f52b36ee)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/de690b40-37b2-47bb-ba70-84d1d0c3ac50)


</b></details>

## 8. Test Locally with Docker-compose

<details>
<summary><a name="8-test-locally-with-docker-compose"></a>8.1 Test Locally with Docker-compose</summary><br><b>

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/89d7cd61-3a60-43f4-98a6-1d52692e4882)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/079ddade-6f6e-4e27-8e34-e3f69367fa2e)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/d7dd19f3-a88e-41ec-8726-1d51bbd58033)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/f551a643-d05d-4049-89bd-e8e9079363ae)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/9dbd52c7-d1d3-4689-a094-2b9361204c1e)

![image](https://github.com/amrashraf-web/Project_App/assets/82893114/fda809dd-389f-4202-9fd0-883ba48e67ba)

</b></details>

<div align="center">
  <h1 style="color: yellow;"> :100: Conclusion</h1>
  <h2>Deploying a Flask application using Kubernetes and Jenkins can seem complex, but with this guide, you now have a clear roadmap to follow. By carefully following each step, you'll establish a robust deployment process that streamlines your workflow and ensures the successful deployment of your projects. Remember, practice makes perfect, so don't hesitate to experiment and adapt the process to your specific needs. Congratulations on taking this significant step toward enhancing your development and deployment skills!</h2>
</div>
