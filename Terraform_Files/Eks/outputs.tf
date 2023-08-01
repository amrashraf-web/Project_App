output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "node_worker_name" {
  value = aws_iam_role.worker.name
}


output "eks_profile_name" {
  value = aws_iam_instance_profile.worker.name
}

