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
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    dir("terraform/infra") {
                        sh 'export AWS_ACESS_KEY_ID=USERNAME'
                        sh 'export AWS_SECRET_ACCESS_KEY=PASSWORD'
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('terraform plan') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    dir("terraform/infra") {
                        sh 'export AWS_ACESS_KEY_ID=USERNAME'
                        sh 'export AWS_SECRET_ACCESS_KEY=PASSWORD'
                        sh 'terraform plan'
                    }
                }
            }
        }
        stage('terraform apply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    dir("terraform/infra") {
                        sh 'export AWS_ACESS_KEY_ID=USERNAME'
                        sh 'export AWS_SECRET_ACCESS_KEY=PASSWORD'
                        sh 'terraform apply'
                    }
                }
            }
        }
    }
}

