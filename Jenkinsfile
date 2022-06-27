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

        stage('Test') {
            steps {
                 sh './jenkins/test/test.sh mvn test'
            }

        }

        stage('Push') {
            steps {
                  sh './jenkins/push/push.sh'
            }
        }

        stage('Deploy') {
            steps {
                  sh 'echo deploy'
                # sh './jenkins/deploy/deploy.sh'
            }
        }
    }
}
