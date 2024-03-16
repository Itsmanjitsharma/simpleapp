pipeline {
    agent { label 'agent' }
    
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment{
         APP_NAME = "simpleapp-pipeline"
         RELEASE = "1.0.0"
         DOCKER_USER = "itsmanjitsharma132"
         DOCKER_PASS = "dockerhub"
         IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
         IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages {
        stage('Cleanup workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout from SCM') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Itsmanjitsharma/simpleapp'
            }
        }
        stage('Build Application') {
            steps {
                sh "mvn clean package"
            }
        }
        stage('Test Application') {
            steps {
                sh "mvn test"
            }
        }
        stage("Build & Push Docker Image"){
            steps{
                script{
                    docker.withRegistry('',DOCKER_PASS){
                        docker_image = docker.build "${IMAGE_NAME}"
                    }
                    docker.withRegistry('',DOCKER_PASS){
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }
        stage("Trivy Scan"){
             steps{
                    script{
                        sh ('docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image itsmanjitsharma132/simpleapp-pipeline:latest --no-progress --scanners vuln --exit-code 0 --severity HIGH,CRITICAL --format table')
                    }
             }
        }
        stage('Cleanup Artifacts') {
       steps {
        script {
            sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}" || true
            sh "docker rmi ${IMAGE_NAME}:latest" || true
           }
       }
     }
    }
}
