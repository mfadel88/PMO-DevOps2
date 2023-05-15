  # Adding Backend as S3 for Remote State Storage
 terraform {
   
  backend "s3" {
    bucket      = "pmo-terraform-bucket"
    key         = "test/eks-cluster/terraform.tfstate"
    region      = "us-east-1"
    
 
    dynamodb_table = "pmo-dynamo-terraform-table"
  }
 }