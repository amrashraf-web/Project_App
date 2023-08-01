output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "jenkins_instance_public_ip" {
  value = module.ec2.Project_Server
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}