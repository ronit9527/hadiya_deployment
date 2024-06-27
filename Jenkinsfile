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
}
}
