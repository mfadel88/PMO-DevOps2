# EKS Cluster
resource "aws_eks_cluster" "pmo-eks-cluster" {
  name     = "PMO-EKS-Cluster"
  role_arn = aws_iam_role.cluster.arn
  version  = "1.25"

  vpc_config {
    #flatten function to put more than one list in the same list of values as below
    subnet_ids              = [module.Network.PRI-SN1, module.Network.PRI-SN2]
    # allow access to  Private and public subnets
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }
  #To determine the EKS cluster ip service cidr.
  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }


  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}


# EKS Cluster IAM Role
resource "aws_iam_role" "cluster" {
  name = "${var.eks-cluster-name}-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
# associate IAM Policy to IAM Role
    /*
      This is an AWS managed policy that grants the necessary permissions for EKS
      to create and manage other AWS resources, such as Amazon Elastic Load Balancers (ELBs) and Auto Scaling groups.
    */
resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

# This Policy to automatically control, handeld, and create VPC's recource or every thing related to VPC such as Security group for EKS cluster and nodes 
resource "aws_iam_role_policy_attachment" "eks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster.name
}




/* # EKS Cluster Security Group
resource "aws_security_group" "eks_cluster" {
  name        = "${var.projectname}-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.projectname}-cluster-sg"
  }
}

resource "aws_security_group_rule" "cluster_inbound" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_outbound" {
  description              = "Allow cluster API Server to communicate with the worker nodes"
  from_port                = 1024
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port                  = 65535
  type                     = "egress"
} */