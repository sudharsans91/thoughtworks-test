pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'https://hub.docker.com/r/sudharshu91/tw-ss-mediawiki'
        KUBE_NAMESPACE = 'ss'
        KUBE_SERVER = 'your-kube-server'
        KUBE_CREDENTIALS = credentials('your-kube-credentials-id')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/sudharsans91/thoughtworks-test']]])
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t https://hub.docker.com/r/sudharshu91/tw-ss-mediawiki/your-app:latest ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${DOCKER_REGISTRY}/your-app1:${BUILD_NUMBER}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubectlApply(
                        credentialsId: KUBE_CREDENTIALS,
                        serverUrl: 'ss-tw-aks-dns-pfgsgl1q.hcp.southindia.azmk8s.io',
                        namespace: 'ss',
                        manifests: 'path/to/kubernetes-manifests.yaml'
                    )
                }
            }
        }
    }
}
