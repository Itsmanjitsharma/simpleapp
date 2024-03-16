pipeline {
    agent { label 'agent' }
    
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    stages{
        stage('Cleanup workspace'){
             steps{
                cleanWs()
             }
        }
        stage('Checkout from SCM'){
            step{
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Itsmanjitsharma/simpleapp'
            }
        }
        stage('Build Application'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('Test Appliction'){
            steps{
                sh "mvn test"
            }
    }
}