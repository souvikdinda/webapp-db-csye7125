def releaseTag

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

        stage('Semantic-Release') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github_token', usernameVariable: 'GH_USERNAME', passwordVariable: 'GH_TOKEN')]) {
                        env.GIT_LOCAL_BRANCH = 'main'
                        sh "mv release.config.js release.config.cjs"
                        sh "npm install @semantic-release/commit-analyzer@8.0.1"
                        sh "npm install @semantic-release/git@9.0.1"
                        sh "npx semantic-release"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    releaseTag = sh(returnStdout: true, script: 'git describe --tags --abbrev=0').trim()
                    echo "Release tag is ${releaseTag}"
                    sh "docker build -t quay.io/csye-7125/webapp-db:${releaseTag} ."
                    sh "docker tag quay.io/csye-7125/webapp-db:${releaseTag} quay.io/csye-7125/webapp-db:latest"
                }
            }
        }

        stage('Push Docker Image to Quay.io') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'quay_credentials', usernameVariable: 'QUAY_USERNAME', passwordVariable: 'QUAY_PASSWORD')]) {
                        sh "docker login -u $QUAY_USERNAME -p $QUAY_PASSWORD quay.io"
                    }
                    sh "docker push quay.io/csye-7125/webapp-db:${releaseTag}"
                    sh "docker push quay.io/csye-7125/webapp-db:latest"
                }
            }
        }
    }

    post {
        success {
            sh "echo 'Running post build actions for deployment'"
            build job: 'webapp-helm-chart-deployment', wait: false
        }
    }

}