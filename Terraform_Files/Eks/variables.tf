variable "cluster_name" {
  description = "The name of the EKS cluster."
}

variable "node_group_name" {
  description = "The name of the node group name."
}

variable "worker_template" {
  description = "The name of the Worker Template."
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "security_group" {
  description = "The ID Of Security Group"
}
