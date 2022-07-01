pipeline {

    agent any
   
    environment {
        DOCKER_HUB_PASS = credentials('DOCKER_HUB_PASS')
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
                  sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 611601100250.dkr.ecr.ap-south-1.amazonaws.com'
                  sh 'docker tag app:$OLD_BUILD_TAG 611601100250.dkr.ecr.ap-south-1.amazonaws.com/avangels-test:$NEW_BUILD_TAG'
                  sh 'docker tag app:$OLD_BUILD_TAG 611601100250.dkr.ecr.ap-south-1.amazonaws.com/avangels-test:latest'
                  sh 'docker push 611601100250.dkr.ecr.ap-south-1.amazonaws.com/avangels-test:$NEW_BUILD_TAG'
                  sh 'docker push 611601100250.dkr.ecr.ap-south-1.amazonaws.com/avangels-test:latest'
            }
        }

        stage('Deploy') {
            steps {
                  sh 'echo deploy'
            }
        }
    }
}
