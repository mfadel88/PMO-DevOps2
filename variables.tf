#### Network VARS ####
# VPC CIDR Block
variable "vpc_cidr_block" {
  type = string
}

# Subnets cidr Blocks
variable "PRI-SN1-cider" {
  type = string
}

variable "PRI-SN2-cider" {
  type = string
}

variable "PUB-SN1-cider" {
  type = string
}

variable "PUB-SN2-cider" {
  type = string
}



#### EKS VARS #######
variable "eks-cluster-name" {
    type = string
    default = "pmo-eks-cluster"
}

variable "cluster_service_ipv4_cidr" {
  description = "Service ipv4 cidr for the Kubernetes Cluster"
  type = string
  default = null # default: 10.100.0.0/20   null to overwrite the default if not defined on the terraform file will alert me to give value
}