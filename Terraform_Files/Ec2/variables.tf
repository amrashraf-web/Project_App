variable "instance_type" {
  description = "The instance type for the EC2 instance."
}

variable "key_pair_name" {
  description = "The name of the key pair for SSH access to the EC2 instance."
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
}

variable "public_subnet_ids" {
  description = "The ID of the subnet where the EC2 instance will be launched."
  type = list(string)
}


variable "security_group" {
  description = "The ID of the security_group where the EC2 instance will be launched."
}

variable "eks_profile_name" {
  description = "The Name of Eks Profile Name where the EC2 instance will be launched."
}
