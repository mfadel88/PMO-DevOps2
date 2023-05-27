
# PMO-project-Task
Project is to Automate the Deployment of a Web Application on Amazon EKS using Terraform to have a fully automated CI/CD solution.

# project Chart
![PMO-Digram](https://github.com/mfadel88/PMO-DevOps2/assets/93100689/12583e58-0c92-435d-8757-fc899de1105c)

# Tools
- ### Terraform
   - A tool for implementing infrastructure as a code to manage application infrastructure on the AWS cloud platform.
- ### Amazon Web Services (AWS)
   - The cloud provider from Amazon that we'll utilize for deploying our project.

- ### GitHub
   - The platform where developers store their source code and collaborate on projects.

- ### Jenkins
   - A CI/CD tool employed for building and deploying our applications.


- ### Steps:
 - Create Network module
 - Create EKS Cluster
 - Create IAM role for EKS Cluster
 - Create Private EKS Node Group
 - Create IAM role for EKS Node Group
 - Creaete IAM Role Amazon-EKS-VPC-Resource Controller
 - Craete IAM Role Amazon-AmazonEKS_CNI_Policy
 - Create Amazon Elastic Container registrty - ECR
 - Create IAM Role Amazon-EC2-Container Registry-ReadOnly
 - Create Ec2 for Jenkins tool as a Services
 - Execute Terraform Commands

    ### Terraform Initialize
       terraform init

    ### Terraform Validate
       terraform validate

    ### Terraform plan
       terraform plan

    #### Terraform Apply
       terraform apply -auto-approve


# Installation:
   - Install "kubectl CLI"
   - Configure kubeconfig for kubectl
    ## Configure kubeconfig for kubectl
      aws eks --region <region-code> update-kubeconfig --name <cluster_name>

    # List Worker Nodes
      kubectl get nodes
      kubectl get nodes -o wide

    # Verify Services
      kubectl get svc



