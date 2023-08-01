provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "./Vpc"
  vpc_name = "Sprints_Vpc"
  cidr_block = "10.0.0.0/16"
}

module "public_subnets" {
  source        = "./Subnets"
  vpc_id        = module.vpc.vpc_id
  cidr_blocks = {
    "public1" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      name              = "Public_Subnet_1"
    },
    "public2" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      name              = "Public_Subnet_2"
    }
  }
}

module "internet_gateway" {
  source              = "./Internet_Gateway"
  vpc_id              = module.vpc.vpc_id
  Internet_Gateway = "Sprints-Internet-Gateway"
}

module "route_table" {
  source              = "./Route_Table"
  vpc_id              = module.vpc.vpc_id
  IGW                 = module.internet_gateway.internet_gateway_id
  public_subnet_ids = module.public_subnets.subnet_ids
  route_name = "Public_Route_Table"
}

module "security_group" {
  source  = "./Security_Group"
  vpc_id  = module.vpc.vpc_id
  Security_Group_Name = "Sprints_Security_Group"
}


module "eks" {
  source = "./Eks"
  public_subnet_ids = module.public_subnets.subnet_ids
  security_group = module.security_group.security_group_id
  cluster_name = "sprints-eks-cluster"
  node_group_name = "sprints-node-group"
  worker_template = "worker-template-eks-profile"
}


module "ec2" {
  depends_on              = [module.eks]
  source = "./Ec2"
  public_subnet_ids = module.public_subnets.subnet_ids
  security_group = module.security_group.security_group_id
  eks_profile_name = module.eks.eks_profile_name
  instance_type = "t3.large"
  key_pair_name = "amora"
  instance_name = "Project_Server"
}

module "ecr" {
  source = "./Ecr"
  repository_name = "flask-app-repo"
}

