pipeline {
    agent { label 'jenkin-agent' }
    
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    
    environment {
        PATH = "/usr/local/bin:${PATH}"
        APP_NAME = "simpleapp"
        RELEASE = "1.0.0"
        DOCKER_USER = "itsmanjitsharma132"
        DOCKER_PASS = credentials('dockerhub')
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}" 
        DOCKER_BUILDKIT = '1'
    }
    
    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }
        
        stage("Checkout from SCM") {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Itsmanjitsharma/simpleapp'
            }
        }
        
        stage("Build Application") {
            steps {
                sh "mvn clean package"
            }
        }
        
        stage("Test Application") {
            steps {
                sh "mvn test"
            }
        }
        
        stage("Check Docker Version") {
            steps {
                sh "docker --version"
            }
        }
        
        stage("Build & Push Docker Image") {
            steps {
                script {
                    /*sh 'docker buildx create --use'
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_PASS) {
                        sh "docker buildx build --platform linux/amd64,linux/arm64 -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest . --push"
                    }*/
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
                    sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
    }
}
