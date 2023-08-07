# Flask App Project Setup Guide

## Table of Contents
- [1. Prerequisites](#1-prerequisites)
  - [1.1 GitHub Account and Token](#11-github-account-and-token)
  - [1.2 AWS Account and Access-Secret Key](#12-aws-account-and-access-secret-key)
  - [1.3 AWS Key Pair](#13-aws-key-pair)
  - [1.4 Ubuntu Machine](#14-ubuntu-machine)
- [2. Install Dependencies and Prepare Infrastructure](#2-install-dependencies-and-prepare-infrastructure)
  - [2.1 Clone the Project](#21-clone-the-project)
  - [2.2 Install Terraform and Ansible](#22-install-terraform-and-ansible)
  - [2.3 Prepare Infrastructure](#23-prepare-infrastructure)
- [3. Automate Infrastructure and Dependencies](#3-automate-infrastructure-and-dependencies)
  - [3.1 Replace Private Key in Ansible](#31-replace-private-key-in-ansible)
  - [3.2 Run Deployment Script](#32-run-deployment-script)
- [4. Update Jenkins with Dependencies](#4-update-jenkins-with-dependencies)
  - [4.1 Access Jenkins](#41-access-jenkins)
  - [4.2 Add GitHub and AWS Keys](#42-add-github-and-aws-keys)
- [5. Create Deployment Pipeline](#5-create-deployment-pipeline)
  - [5.1 Configure Jenkins Job](#51-configure-jenkins-job)
  - [5.2 Run the Pipeline](#52-run-the-pipeline)
- [6. Check Pods and Nodes](#6-check-pods-and-nodes)
- [7. Test Locally with Docker-compose](#7-test-locally-with-docker-compose)
- [8. Test Project and Database](#8-test-project-and-database)

## 1. Prerequisites

### 1.1 GitHub Account and Token

1. **Login to GitHub**: Log in to your GitHub account.
2. **Access Personal Access Tokens**: Go to your GitHub settings. Click on your profile picture in the top right corner, then select "Settings".
3. **Access Developer Settings**: In the left sidebar, under "Developer settings", click on "Personal access tokens".
4. **Generate New Token**: Click the "Generate new token Classic" button.
5. **Configure Token Permissions**: Give your token a meaningful name and select the necessary permissions. Be cautious not to grant more permissions than necessary.
6. **Select Scopes**: GitHub offers various scopes for different permissions. Choose the ones that align with your requirements.
7. **Generate Token**: After configuring permissions, click the "Generate token" button at the bottom of the page.
8. **Copy Token**: GitHub will generate a token for you. Copy this token and store it securely.

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
     git clone https://github.com/amrashraf-web/Project_App
     ```

### 2.2 Install Terraform and Ansible

  1. **Install Dependencies**: Navigate to the project folder and install Terraform and Ansible.
     ```
     cd ~/Project_App
     chmod +x Install_Terrafrom_Ansible.sh
     ./Install_Terrafrom_Ansible.sh
     ```

### 2.3 Prepare Infrastructure
Configure your access-secret key in Terraform files and update necessary information.

## 3. Automate Infrastructure and Dependencies

1. **Replace Private Key**: Replace your private key pair in Ansible configuration.
2. **Run Deployment Script**: Navigate to the project folder and run the deployment script.
   ```
   cd ~/Project_App
   chmod +x Deploy.sh
   ./Deploy.sh
   ```
   
### 3.1 Replace Private Key in Ansible
Update your private key in Ansible configuration.

### 3.2 Run Deployment Script
Automate infrastructure deployment and dependencies installation.

## 4. Update Jenkins with Dependencies

1. **Access Jenkins**: Access the URL provided in the Ansible output and log in with your admin API token.
2. **Install Plugins**: Click "Install suggested plugins" and wait for the installation to finish.
3. **Create User**: Create a user with necessary information.
4. **Start Jenkins**: Click "Start Jenkins".
5. **Add GitHub and AWS Keys**:

   - GitHub Key:
     - Go to Manage Jenkins > Credentials > System > Global credentials (unrestricted) > Add credentials.
     - Use Username with password, scope Global.
     - Provide your GitHub username and token.

   - AWS Key:
     - Go to Manage Jenkins > Credentials > System > Global credentials (unrestricted) > Add credentials.
     - Use Username with password, scope Global.
     - Provide your AWS Access Key and Secret Key.
     - 
### 4.1 Access Jenkins
Access Jenkins using the provided URL and login with your admin API token.

### 4.2 Add GitHub and AWS Keys
Add your GitHub and AWS keys to Jenkins for authentication.

## 5. Create Deployment Pipeline

### 5.1 Configure Jenkins Job
Create a Jenkins pipeline job and configure the pipeline script.

### 5.2 Run the Pipeline
Start the pipeline and monitor the progress.

## 6. Check Pods and Nodes

Check your Kubernetes cluster's nodes and pods.

## 7. Test Locally with Docker-compose

Test your project locally using Docker-compose.

## 8. Test Project and Database

Test your project functionality and check if the database is working.

