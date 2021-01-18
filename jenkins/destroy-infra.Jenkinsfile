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
                        sh '''
                           export AWS_DEFAULT_REGION="eu-central-1"
                           export AWS_ACCESS_KEY_ID="${USERNAME}"
                           export AWS_SECRET_ACCESS_KEY="${PASSWORD}"
                           terraform init
                        '''
                    }
                }
            }
        }
        stage('terraform plan') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    dir("terraform/infra") {
                        sh '''
                            export AWS_DEFAULT_REGION="eu-central-1"
                            export AWS_ACCESS_KEY_ID=${USERNAME}
                            export AWS_SECRET_ACCESS_KEY=${PASSWORD}
                            terraform plan
                        '''
                    }
                }
            }
        }
        stage('terraform destroy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    dir("terraform/infra") {
                        sh '''
                            export AWS_DEFAULT_REGION="eu-central-1"
                            export AWS_ACCESS_KEY_ID=${USERNAME}
                            export AWS_SECRET_ACCESS_KEY=${PASSWORD}
                            terraform destroy -auto-approve
                        '''
                    }
                }
            }
        }
    }
}

