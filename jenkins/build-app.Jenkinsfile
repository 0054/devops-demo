#!groovy

pipeline {
    agent {
        label 'docker'
    }
    // parameters {}
    stages {
        stage('Clean Work Space') {
            steps {
                cleanWs()
            }
        }
        stage('checkout') {
            steps {
                checkout scm
            }
        }
        stage('build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    dir("python/app") {
                        sh 'make build'
                    }
                }
            }
        }
        stage('push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    dir("terraform/infra") {

                        sh '''
                            sudo docker --username "${USERNAME}" --password "${PASSWORD}"
                            make push
                            '''
                    }
                }
            }
        }
    }
}

