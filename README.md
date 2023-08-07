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
Follow these steps to generate a GitHub token with appropriate permissions.

### 1.2 AWS Account and Access-Secret Key
Learn how to create an AWS user with necessary permissions and generate an access-secret key.

### 1.3 AWS Key Pair
Generate an AWS key pair for secure access to your instances.

### 1.4 Ubuntu Machine
Ensure you have access to an Ubuntu machine.

## 2. Install Dependencies and Prepare Infrastructure

### 2.1 Clone the Project
Clone the project repository to your home directory.

### 2.2 Install Terraform and Ansible
Install Terraform and Ansible on your machine and set up dependencies.

### 2.3 Prepare Infrastructure
Configure your access-secret key in Terraform files and update necessary information.

## 3. Automate Infrastructure and Dependencies

### 3.1 Replace Private Key in Ansible
Update your private key in Ansible configuration.

### 3.2 Run Deployment Script
Automate infrastructure deployment and dependencies installation.

## 4. Update Jenkins with Dependencies

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

