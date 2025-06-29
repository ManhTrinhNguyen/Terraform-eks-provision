## Create VPC for EKS 

data "aws_availability_zones" "my-azs" {
  all_availability_zones = true 
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"
  name = "eks-vpc"
  cidr = var.vpc_id

  azs = data.aws_availability_zones.my-azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true 
  single_nat_gateway = true 
  enable_dns_hostnames = true 

  tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}