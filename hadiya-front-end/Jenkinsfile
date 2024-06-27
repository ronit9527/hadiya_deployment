pipeline {
    agent any
    
    environment {
        S3_BUCKET = "hadiya-bucket"
    }
  tools {
        nodejs "NodeJS 14"  // The name you provided in the Global Tool Configuration
    }
    
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }
      
  
  stage('Install Dependencies') {
            steps {
                script {
                    // Install project dependencies
                    sh '''
                        cd hadiya-front-end
                        npm install
                    '''
                }
            }
        }
  stage('Build Angular Project') {
            steps {
                script {
                    // Build the Angular project
                    sh '''
                        cd hadiya-front-end
                        npm run build --prod
                    '''
                }
            }
        }
  stage('Deploy to S3') {
            steps {
                script {
                    // Upload files to S3
                    sh '''
                       for file in hadiya-front-end/dist/*; do
                            aws s3 cp $file s3://${S3_BUCKET}/$(basename $file) --region us-west-1
                       done 
                    '''
                }
            }
        }
}
}
