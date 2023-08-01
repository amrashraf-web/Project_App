variable "vpc_id" {
  description = "The ID of the VPC where the subnets will be created."
}

variable "cidr_blocks" {
  description = "Configuration for subnets"

  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
}