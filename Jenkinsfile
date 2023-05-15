pipeline {
    agent any 
       environment {
        AWS_ECR_URL = "616382673542.dkr.ecr.us-east-1.amazonaws.com"
       }
    stages {
        stage('Build') {
            steps {
                // Build Docker image
                script {
                    withAWS([file(credentialsId: 'pmo-cred', region: "us-east-1")]) {
                    aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin ${AWS_ECR_URL}
                    sh """
                    docker build -t pmo-service:1.0 . 
                    docker tag pmo-service:1.0 616382673542.dkr.ecr.us-east-1.amazonaws.com/pmo-service:1.0
                    docker puch 616382673542.dkr.ecr.us-east-1.amazonaws.com/pmo-service:1.0

                    """
                    }
                }
            }
        }
 
        stage('Deploy') {
            steps {
                // Deploy to EKS cluster
                script {
                    withCredentials([file(credentialsId: 'pmo-cred', variable: 'awsCredentials')]) {
                        withAWS(region: '<aws-region>', credentials: 'awsCredentials') {
                            eksUpdateKubeconfig(
                                clusterName: '<eks-cluster-name>',
                                kubeconfigId: '<kubeconfig-id>'
                            )
                            sh 'kubectl apply -f deployment.yaml'
                        }
                    }
                }
            }
        }
    }
}