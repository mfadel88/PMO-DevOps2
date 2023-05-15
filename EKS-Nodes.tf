# EKS Node Groups
resource "aws_eks_node_group" "pmo-cluster-nodes" {
  cluster_name    = aws_eks_cluster.pmo-eks-cluster.name
  node_group_name = "${var.eks-cluster-name}-group-nodes"
  node_role_arn   = aws_iam_role.worker-node-role.arn
  subnet_ids      = [module.Network.PRI-SN1, module.Network.PRI-SN2]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  ami_type       = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
  capacity_type  = "ON_DEMAND"  # ON_DEMAND, SPOT
  disk_size      = 20
  instance_types = ["t2.medium"]

 # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1    
 # max_unavailable_percentage = 50    # ANY ONE TO USE
  }

 # this mean that dont run this cluster without those debencies
  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]

   tags = {
    name = "PMO-node"
    Environment = "PMO-Task"
  }

}


# EKS Node IAM Role
resource "aws_iam_role" "worker-node-role" {
  name = "${var.eks-cluster-name}-Worker-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#To permite worker node to connect with master node 
resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker-node-role.name
}

#To handle the network connection between all the pods which are runnin on all cluster nodes 
resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker-node-role.name
}

#To enable nodes access to ECR in order to be enable push images on it
resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker-node-role.name
}


/* # EKS Node Security Group
resource "aws_security_group" "eks_nodes" {
  name        = "${var.project}-node-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                                           = "${var.project}-node-sg"
    "kubernetes.io/cluster/${var.project}-cluster" = "owned"
  }
}

resource "aws_security_group_rule" "nodes_internal" {
  description              = "Allow nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "nodes_cluster_inbound" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_cluster.id
  to_port                  = 65535
  type                     = "ingress"
} */