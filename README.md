# Flask App Project

## Prerequisites

### 1. You Must Have A Github Account And Generate Token

1. **Login to GitHub**: Log in to your GitHub account.
2. **Access Personal Access Tokens**: Go to your GitHub settings. Click on your profile picture in the top right corner, then select "Settings".
3. **Access Developer Settings**: In the left sidebar, under "Developer settings", click on "Personal access tokens".
4. **Generate New Token**: Click the "Generate new token Classic" button.
5. **Configure Token Permissions**: Give your token a meaningful name and select the necessary permissions. Be cautious not to grant more permissions than necessary.
6. **Select Scopes**: GitHub offers various scopes for different permissions. Choose the ones that align with your requirements.
7. **Generate Token**: After configuring permissions, click the "Generate token" button at the bottom of the page.
8. **Copy Token**: GitHub will generate a token for you. Copy this token and store it securely.

### 2. You Must Have An AWS Account (Generate Access-Secret Key With Admin Permission)

1. **Login to AWS Console**: Log in to your AWS Management Console.
2. **Access IAM**: Go to the "Identity and Access Management (IAM)" service.
3. **Access Users**: In the IAM dashboard, select "Users" from the left sidebar.
4. **Add User**: Click the "Add user" button.
5. **User Details**: Provide a username for the new user. Select "Programmatic access" to generate access keys for API interactions.
6. **Set Permissions**: Choose between adding the user to a group with necessary permissions or attaching policies directly to the user.
7. **Generate Access Key**: After creating the user, generate an access key.
8. **Copy Token**: AWS will generate an access-secret key pair. Copy these keys and store them securely.

### 3. You Must Have AWS Key Pair

1. **Login to AWS Console**: Log in to your AWS Management Console.
2. **Access EC2 Dashboard**: Go to the "EC2 Dashboard" from the services menu.
3. **Key Pairs**: In the EC2 dashboard, select "Key Pairs" from the left sidebar under the "Network & Security" section.
4. **Create Key Pair**: Click the "Create Key Pair" button.
5. **Key Pair Name**: Give your key pair a name. Choose "pem" format to generate a .pem file containing your private key.
6. **Create Key Pair**: Click the "Create Key Pair" button.
7. **Download Key Pair**: After creating the key pair, the private key will be automatically downloaded.

### 4. Set Up an Ubuntu Machine

## Install All Dependencies And Prepare Our Infrastructure

### 1. Clone This Project

1. **Clone Project**: Clone this project into your home directory with the provided command.

### 2. Install Terraform And Ansible

1. **Install Dependencies**: Navigate to the project folder and install Terraform and Ansible.

### 3. Prepare Infrastructure

1. **Configure Access-Secret Key**: Put your Access-Secret Key in Terraform files and update the dependencies.

## Let's Automate Our Infrastructure And Install Dependencies

1. **Replace Private Key**: Replace your private key pair in Ansible configuration.
2. **Run Deployment Script**: Navigate to the project folder and run the deployment script.

## Update Jenkins With Credentials And Create Pipeline

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

## Create The Pipeline To Deploy The Project

1. **Create Pipeline**: Create a pipeline job and configure it.

## Check Pods And Nodes

1. **Connect To Server**: Connect to the server with Jenkins.
2. **Configure AWS**: Configure AWS credentials.
3. **Update eks Configuration**: Update eks configuration for kubectl.
4. **Check Nodes**: Check cluster nodes.
5. **Check Pods**: Check all pods, stateful sets, and configurations.

## Test Docker-compose Locally

![Docker-compose Test](screenshot_number_7.png)

## Testing The Project And Database

![Project Testing](screenshot_number_8.png)
