pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps{
                script {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: 'main']],
                        userRemoteConfigs: [[credentialsId: 'github_token', url: 'https://github.com/csye7125-fall2023-group07/webapp-db.git']]
                    ])
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    //sh "docker build -t quay.io/csye-7125/webapp-db:${releaseTag} ."
                    sh "docker build -t ${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG} ."
                }
            }
        }

        stage('Push Docker Image to Quay.io') {
            steps {
                script {
                    // Log in to Quay.io using your credentials
                    withCredentials([usernamePassword(credentialsId: 'quay_credentials', usernameVariable: 'QUAY_USERNAME', passwordVariable: 'QUAY_PASSWORD')]) {
                        sh "docker login -u $QUAY_USERNAME -p $QUAY_PASSWORD quay.io"
                    }
                    // Push the Docker image to Quay.io
                    //sh "docker push quay.io/csye-7125/webapp-db:${releaseTag}"
                    sh "docker push ${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}"
                }
            }
        }
    }

}