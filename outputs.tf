/* # VPC CIDR block
output "vpc_cider_block" {
  description = "The CIDR block of the VPC"
  value = module.vpc.vpc_cidr_block
}
 
# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of Private subnets"
  value = module.vpc.private_subnets
}
 
# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of Public subnets"
  value = module.vpc.public_subnets
} */