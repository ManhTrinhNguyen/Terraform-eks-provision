module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.35.0"

  cluster_name = "eks-cluster"
  cluster_version = "1.32"

  cluster_addons = {
    coredns = {}
    eks-pod-identity-agent = {}
    kube-proxy = {}
    vpc-cni = {}

    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  cluster_endpoint_public_access = true
  
  enable_cluster_creator_admin_permissions = true

  vpc_id = module.vpc.vpc_id
  subnet_ids = [ module.vpc.private_subnets[2]]

  control_plane_subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]

  eks_managed_node_groups = {
    my-node-group = {
      ami_type = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size = 1
      max_size = 3
      desired_size = 2

      iam_role_additional_policies = { AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" }
    }
  }

  tags = {
    environment = "dev"
    application = "myapp"
  }
}
