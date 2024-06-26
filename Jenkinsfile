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
                        aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x8p9m7t4
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
    stage('Update Deployment File') {
            steps {
                script {
                    sh '''
                        dir=`pwd`
                        echo "$dir"
                        sed -i "s|public.ecr.aws/x8p9m7t4/hadiya:latest|${ECR_REGISTRY}/${REPOSITORY_NAME}:${BUILD_NUMBER}|" deployment.yml
                        cat deployment.yml
                    '''
                }
            }
        }
    stage('Integrate Jenkins with EKS Cluster and Deploy App') {
            steps {
                withAWS(credentials: '26970895-9275-456c-aa00-bf18d582d0e1', region: '${REGION}') {
                script {
                    sh ''' 
                      aws eks update-kubeconfig --name hadiya-cluster --region ${REGION}
                      kubectl apply -f deployment.yml
                    '''
                }
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
