module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  #version         = "19.14.0"
  version         = "20.29.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  vpc_id          = module.vpc.vpc_id
  subnet_ids      = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  eks_managed_node_groups = {
    node-ada = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = var.ami_type
      instance_types = var.instance_type

      min_size = 2
      max_size = 5
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2
    }
  }

  tags = local.common_tags
}