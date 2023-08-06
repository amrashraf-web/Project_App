# Project Installation Guide

This guide will walk you through the installation process for setting up an EKS cluster, Jenkins, Docker, Kubernetes, and related components for your project. Follow the steps below to get started.

## Prerequisites

Before you begin, ensure you have the following prerequisites installed and configured:

- [GitHub Repository](https://github.com/uym2/MySQL-and-Python)
- AWS Account with necessary permissions
- Docker
- Terraform
- Ansible

## Table of Contents

1. [Terraform Setup](#terraform-setup)
2. [Jenkins Installation](#jenkins-installation)
3. [AWS and Kubernetes Configuration](#aws-and-kubernetes-configuration)
4. [Docker Image and Compose](#docker-image-and-compose)
5. [Kubernetes Deployment](#kubernetes-deployment)
6. [Jenkins Configuration](#jenkins-configuration)
7. [Project Scripts](#project-scripts)
8. [Expected Deliverables](#expected-deliverables)

## 1. Terraform Setup

Follow the instructions in the [Terraform Scripts Repository](https://github.com/uym2/MySQL-and-Python) to create an EKS cluster, an EC2 instance for Jenkins, and an ECR repository.

## 2. Jenkins Installation

Use Ansible to install and configure Jenkins on the EC2 instance:

- Install Jenkins
- Configure Jenkins access
- Install necessary plugins

## 3. AWS and Kubernetes Configuration

- Add AWS credentials to Jenkins
- Configure Kubernetes access (kubeconfig)

## 4. Docker Image and Compose

- Fork the provided GitHub repository
- Create a Docker image for your code
- Create a Docker compose file for your code and database

## 5. Kubernetes Deployment

Create Kubernetes files for:

- Deployment of the Python code
- StatefulSet for MySQL with PVs and PVCs
- Services for both the database and code
- ConfigMap and Secrets for the code
- Ingress using NGINX Controller

## 6. Jenkins Configuration

- Install NGINX Controller to the EKS cluster
- Configure Jenkins pipeline-as-code to build from GitHub on every push
- Configure GitHub webhooks to integrate with Jenkins
- Set up the pipeline to:
  - Build new Docker images
  - Push images to ECR
  - Deploy images to Kubernetes

## 7. Project Scripts

Use the provided bash script to run Terraform and Ansible files for setup.

```bash
./setup.sh
