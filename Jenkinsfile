pipeline {
    agent any
    
    environment {
        REGION = "us-west-1"
        REPOSITORY_NAME = "hadiya"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        ECR_URI = "public.ecr.aws/x8p9m7t4/${REPOSITORY_NAME}:${IMAGE_TAG}"
        ECR_REGISTRY = "public.ecr.aws/x8p9m7t4"
        
    }
    
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }
    stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh '''
                        cd hadiya-backend
                        docker build -t ${REPOSITORY_NAME}:${IMAGE_TAG} .
                    '''
                }
            }
        }
    stage('Login to ECR') {
            steps {
                script {
                    // Login to Amazon ECR
                    sh '''
                        aws ecr-public get-login-password --region ${REGION} | docker login --username AWS --password-stdin public.ecr.aws/x8p9m7t4
                    '''
                }
            }
        }
    stage('Tag and Push Docker Image') {
            steps {
                script {
                    // Tag and push the Docker image to ECR
                    sh '''
                        docker tag ${REPOSITORY_NAME}:${IMAGE_TAG} ${ECR_URI}
                        docker push ${ECR_URI}
                    '''
                }
            }
        }
    stage('Integrate Jenkins with EKS Cluster and Deploy App') {
            steps {
                script {
                    sh ''' 
                      cd ..
                      aws eks update-kubeconfig --name hadiya-cluster --region ${REGION}
                      kubectl apply -f deployment.yml"
                    '''
                }
        }
    }
    post {   
        always {
            cleanWs() // Clean up workspace after the build
        }
    }
}
