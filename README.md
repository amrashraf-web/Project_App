# :star_struck: Project Setup Guide :star_struck:

Welcome to the project setup guide! This guide will walk you through the necessary steps to set up your project environment, including GitHub, AWS, Terraform, Ansible, Jenkins, and Kubernetes.

## Table of Contents

1. [Prerequisites](#prerequisites)
- [GitHub Account and Token](#github-account-and-token)
- [AWS Account and Access-Secret Key](#aws-account-and-access-secret-key)
- [AWS Key Pair](#aws-key-pair)
- [Ubuntu Machine](#ubuntu-machine)
![Screenshot from 2023-05-16 01-01-59](https://github.com/amrashraf-web/Project_App/assets/128842547/95237572-33ca-4aff-9318-2631baed9a8d)

2. [Install Dependencies and Prepare Infrastructure](#install-dependencies-and-prepare-infrastructure)
    - [Clone Project Repository](#clone-project-repository)
    - [Install Terraform and Ansible](#install-terraform-and-ansible)
    - [Prepare Infrastructure](#prepare-infrastructure)
3. [Automate Infrastructure with Dependencies](#automate-infrastructure-with-dependencies)
4. [Update Jenkins and Configure Credentials](#update-jenkins-and-configure-credentials)
5. [Create Deployment Pipeline](#create-deployment-pipeline)
6. [Check Pods and Nodes](#check-pods-and-nodes)

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

### GitHub Account and Token

1. Log in to GitHub and access your settings.
2. Under "Developer settings," select "Personal access tokens."
3. Generate a new token, choosing the necessary permissions.
4. Copy the generated token securely.

### AWS Account and Access-Secret Key

1. Log in to the AWS Management Console.
2. Access IAM and create a new user with programmatic access.
3. Assign permissions to the user, either through a group or policies.
4. Create an access-secret key for the user and store it securely.

### AWS Key Pair

1. Log in to the AWS Management Console.
2. Access the EC2 Dashboard and create a new key pair.
3. Choose the "pem" format and download the private key.

### Ubuntu Machine

You'll need access to an Ubuntu machine for this setup.

## Install Dependencies and Prepare Infrastructure

Follow these steps to install dependencies and prepare your project infrastructure:

### Clone Project Repository

1. Clone the project repository to your home directory:

   ```sh
   git clone https://github.com/amrashraf-web/Project_App
   
### Install Terraform and Ansible
1. Navigate to the project folder:
    ```sh
    cd ~/Project_App
2. Make the installation script executable:
    ```sh
    chmod +x Install_Terrafrom_Ansible.sh
3. Run the installation script:
    ```sh
    ./Install_Terrafrom_Ansible.sh
### Prepare Infrastructure
1. Put your AWS access-secret key in values.auto.tfvars under Terraform_Files.
2. Update main.tf under Terraform_Files with your dependencies (key_pair_name)
   
## Automate Infrastructure with Dependencies
1. Update ansible_ssh_private_key_file in inventory.ini With Your Private Key
2. Run the deployment script:
    ```sh
    cd ~/Project_App
    chmod +x Deploy.sh
    ./Deploy.sh

## Update Jenkins and Configure Credentials
1. Access the URL obtained from Ansible output and log in.
2. Install suggested plugins and create your admin user.
3. Start Jenkins.
4.Now Will Add Your Gihub Key and Aws Key To Jenkins
   # 1 -  Go To Manage Jenkins > credentials > system > Global credentials (unrestricted) > Add credentials
        A - Use Username with password
        B - Scope Global
        C - in username Field put your github username
        D - in password Field put your key token of github
        E - in ID Field Put github_key
        F - Click Create
   # 2 - Go To Manage Jenkins > credentials > system > Global credentials (unrestricted) > Add credentials
        A - Use Username with password
        B - Scope Global
        C - in username Field put your Aws Access Key
        D - in password Field put your Aws Secret Key
        E - in ID Field Put aws_key
        F - Click Create
