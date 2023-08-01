#!/bin/bash
# amrashraf-web
# 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
# aws_access_key: AKIA32KEJN5DQYJFXVQN
# aws_secret_key: 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
# Define variables for the project paths
base_path=~/Final_Project
terraform_path=${base_path}/Terraform_Files
ansible_path=${base_path}/Ansible_Files
inventory_file=${ansible_path}/inventory.ini

# Function to run Terraform
run_terraform() {
    echo "Running Terraform..."
    cd "${terraform_path}"
    terraform init
    terraform apply -auto-approve
    instance_ip=$(terraform output jenkins_instance_public_ip)
    cd -
    echo "Terraform execution completed."
}

# Function to Update inventory
update_inventory() {
    echo "Updating Ansible inventory..."
    if [ -z "${instance_ip}" ]; then
        echo "Error: instance_ip is empty. Make sure Terraform has been executed successfully."
        exit 1
    fi

    # Replace the IP address of the target host in the inventory file
    echo -e "[Project_Server]\nProject_Server ansible_host=${instance_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa" > "${inventory_file}"

    echo "Ansible inventory updated."
}

# Function to run Ansible
run_ansible() {
    echo "Running Ansible..."
    cd "${ansible_path}"
    export ANSIBLE_HOST_KEY_CHECKING=False
    ansible-playbook -i inventory.ini aws_setup.yml
    cd -
    echo "Ansible execution completed."
}

# Main script
echo "Starting script..."

# Call the functions to run Terraform and Ansible
run_terraform
echo "Done Finished Terraform Successfully"
update_inventory
echo "Done Updated Inventory Successfully"
echo "Please Wait 10 Sec Until The Server Initializes"
sleep 10
run_ansible
echo "Done Finished Ansible Successfully"
echo "Script execution finished."
