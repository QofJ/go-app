pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id') // Docker Hub 凭据 ID
        KUBECONFIG_CREDENTIALS = credentials('kubeconfig-credentials-id') // Kubernetes 凭据 ID
        DOCKER_IMAGE = 'medizana/go-app:latest'
    }
    stages {
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build(DOCKER_IMAGE)
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS, variable: 'KUBECONFIG')]) {
                    script {
                        sh 'kubectl apply -f deployment.yaml --kubeconfig $KUBECONFIG'
                        sh 'kubectl apply -f service.yaml --kubeconfig $KUBECONFIG'
                    }
                }
            }
        }
    }
}