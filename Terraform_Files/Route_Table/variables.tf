variable "route_name" {
  description = "The Name Of Route Table."
}

variable "vpc_id" {
  description = "The ID of the VPC where the route table will be associated."
}

variable "public_subnet_ids" {
  description = "The IDs of the Subnets where the route table will be associated."
}

variable "IGW" {
  description = "The ID of internet gateway."
}
