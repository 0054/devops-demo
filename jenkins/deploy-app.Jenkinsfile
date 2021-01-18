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
        stage('deploy') {
            steps {
                dir("ansible") {
                    sh 'ansible-playbook plabooks/deploy.yml'
                }
            }
        }
    }
}

