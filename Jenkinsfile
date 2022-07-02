pipeline {

    agent any
   
    environment {
        DOCKER_HUB_PASS = credentials('DOCKER_HUB_PASS')

        AWS_ACCOUNT_ID="611601100250"
        AWS_DEFAULT_REGION="ap-south-1" 
        IMAGE_REPO_NAME="avangels-test "
        IMAGE_TAG="3.2"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
  
    }    

    stages {

        stage('Build') {
            steps {
                sh '''
                    ./jenkins/build/mvn.sh mvn -B -DskipTests clean package
                    ./jenkins/build/build.sh

                '''
            }

           post {
               success {
                   archiveArtifacts artifacts: 'java-app/target/*.jar', fingerprint: true
               }
           }
        }

        stage('Test') {
            steps {
                 sh './jenkins/test/test.sh mvn test'
            }

           post {
               always {
                   junit 'java-app/target/surefire-reports/*.xml'
               }
           }


        }

        stage('Push') {
            steps {
                  sh './jenkins/push/push.sh'
            }
        }


        stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }

       // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
         }
        }
     
    }

 
        stage('Deploy') {
            steps {
                  sh 'echo deploy'
            }
        }
    }
}
