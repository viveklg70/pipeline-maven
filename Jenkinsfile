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
                  sh './jenkins/push/push_ecr.sh'
            }
        }

        stage('Deploy') {
            steps {
                  sh 'echo deploy'
            }
        }
    }
}
