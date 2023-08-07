# Flask App Project

## Prerequisites

| Step | Description |
|------|-------------|
| 1    | **You Must Have A Github Account And Generate Token**<br/><br/>1. **Login to GitHub**: Log in to your GitHub account.<br/>2. **Access Personal Access Tokens**: Go to your GitHub settings. Click on your profile picture in the top right corner, then select "Settings".<br/>3. **Access Developer Settings**: In the left sidebar, under "Developer settings", click on "Personal access tokens".<br/>4. **Generate New Token**: Click the "Generate new token Classic" button.<br/>5. **Configure Token Permissions**: Give your token a meaningful name and select the necessary permissions. Be cautious not to grant more permissions than necessary.<br/>6. **Select Scopes**: GitHub offers various scopes for different permissions. Choose the ones that align with your requirements.<br/>7. **Generate Token**: After configuring permissions, click the "Generate token" button at the bottom of the page.<br/>8. **Copy Token**: GitHub will generate a token for you. Copy this token and store it securely. |
| 2    | **You Must Have An AWS Account (Generate Access-Secret Key With Admin Permission)**<br/><br/>1. **Login to AWS Console**: Log in to your AWS Management Console.<br/>2. **Access IAM**: Go to the "Identity and Access Management (IAM)" service.<br/>3. **Access Users**: In the IAM dashboard, select "Users" from the left sidebar.<br/>4. **Add User**: Click the "Add user" button.<br/>5. **User Details**: Provide a username for the new user. Select "Programmatic access" to generate access keys for API interactions.<br/>6. **Set Permissions**: Choose between adding the user to a group with necessary permissions or attaching policies directly to the user.<br/>7. **Generate Access Key**: After creating the user, generate an access key.<br/>8. **Copy Token**: AWS will generate an access-secret key pair. Copy these keys and store them securely. |
| 3    | **You Must Have AWS Key Pair**<br/><br/>1. **Login to AWS Console**: Log in to your AWS Management Console.<br/>2. **Access EC2 Dashboard**: Go to the "EC2 Dashboard" from the services menu.<br/>3. **Key Pairs**: In the EC2 dashboard, select "Key Pairs" from the left sidebar under the "Network & Security" section.<br/>4. **Create Key Pair**: Click the "Create Key Pair" button.<br/>5. **Key Pair Name**: Give your key pair a name. Choose "pem" format to generate a .pem file containing your private key.<br/>6. **Create Key Pair**: Click the "Create Key Pair" button.<br/>7. **Download Key Pair**: After creating the key pair, the private key will be automatically downloaded. |
| 4    | **Set Up an Ubuntu Machine** |

## Install All Dependencies And Prepare Our Infrastructure

| Step | Description |
|------|-------------|
| 1    | **Clone This Project**<br/><br/>1. **Clone Project**: Clone this project into your home directory. |
| 2    | **Install Terraform And Ansible**<br/><br/>1. **Install Dependencies**: Navigate to the project folder and install Terraform and Ansible. |
| 3    | **Prepare Infrastructure**<br/><br/>1. **Configure Access-Secret Key**: Put your Access-Secret Key in Terraform files and update the dependencies. |

## Let's Automate Our Infrastructure And Install Dependencies

| Step | Description |
|------|-------------|
| 1    | **Replace Private Key**<br/><br/>1. **Replace Private Key**: Replace your private key pair in Ansible configuration.<br/>2. **Run Deployment Script**: Navigate to the project folder and run the deployment script. |

## Update Jenkins With Credentials And Create Pipeline

| Step | Description |
|------|-------------|
| 1    | **Access Jenkins**<br/><br/>1. **Access Jenkins**: Access the URL provided in the Ansible output and log in with your admin API token.<br/>2. **Install Plugins**: Click "Install suggested plugins" and wait for the installation to finish.<br/>3. **Create User**: Create a user with necessary information.<br/>4. **Start Jenkins**: Click "Start Jenkins".<br/>5. **Add GitHub and AWS Keys**: ... |
| 2    | **Create The Pipeline To Deploy The Project**<br/><br/>1. **Create Pipeline**: Create a pipeline job and configure it. |

## Check Pods And Nodes

| Step | Description |
|------|-------------|
| 1    | **Connect To Server**<br/><br/>1. **Connect To Server**: Connect to the server with Jenkins.<br/>2. **Configure AWS**: Configure AWS credentials.<br/>3. **Update eks Configuration**: Update eks configuration for kubectl.<br/>4. **Check Nodes**: Check cluster nodes.<br/>5. **Check Pods**: Check all pods, stateful sets, and configurations. |

## Test Docker-compose Locally

![Docker-compose Test](screenshot_number_7.png)

## Testing The Project And Database

![Project Testing](screenshot_number_8.png)
