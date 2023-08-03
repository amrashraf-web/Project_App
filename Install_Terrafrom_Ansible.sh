#!/bin/bash

# Function to check if a Package is available or not
function command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Terraform
function install_terraform() {
    if ! command_exists terraform; then
        echo "Installing Terraform..."
        sudo apt install unzip
        curl -fsSL https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_amd64.zip -o /tmp/terraform.zip
        sudo unzip /tmp/terraform.zip -d /usr/local/bin/
        rm /tmp/terraform.zip
        echo "Terraform installed successfully."
    else
        echo "Terraform is already installed."
    fi
}

# Function to install Ansible
function install_ansible() {
    if ! command_exists ansible; then
        echo "Installing Ansible..."
        sudo apt-get update
        sudo apt-get install -y ansible
        echo "Ansible installed successfully."
    else
        echo "Ansible is already installed."
    fi
}

# Main script starts here
install_terraform
install_ansible

echo "Installation completed."
