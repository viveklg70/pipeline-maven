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
            }
        }

        stage('ECR push') {
            steps {
               script {
                   docker.withRegistry('https://611601100250.dkr.ecr.ap-south-1.amazonaws.com', 
                   'ecr:ap-south-1:jenkins-aws-ecr') {
                   def app.1.3 = docker.build ('avangels-test')
                   app.1.3.push('2.1')
                  }
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
