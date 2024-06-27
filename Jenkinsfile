pipeline {
    agent any
    
    environment {
        REGION = "us-west-1"
        REPOSITORY_NAME = "hadiya"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        ECR_URI = "730335380624.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY_NAME}:${IMAGE_TAG}"
        ECR_REGISTRY = "730335380624.dkr.ecr.${REGION}.amazonaws.com"
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
                        aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}
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
    }
    post {   
        always {
            cleanWs() // Clean up workspace after the build
        }
    }
}
