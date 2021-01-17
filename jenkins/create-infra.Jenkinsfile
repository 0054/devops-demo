#!groovy

String value = 'asd'

pipeline {
    agent {
        label 'master'
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
        stage('terraform init') {
            steps {
                dir("terraform/infra") {
                    sh 'terraform init'
                }
            }
        }
        stage('terraform plan') {
            steps {
                dir("terraform/infra") {
                    sh 'terraform plan'
                }
            }
        }
        stage('terraform apply') {
            steps {
                dir("terraform/infra") {
                    sh 'terraform apply'
                }
            }
        }
    }
}

