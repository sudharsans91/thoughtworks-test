pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'https://hub.docker.com/repository/docker/sudharshu91/tw-ss-mediawiki/'
        K8S_NAMESPACE = 'ss'
        K8S_DEPLOYMENT = 'ss-tw-mediawiki-deployment'
        GIT_REPO_URL = 'https://github.com/sudharsans91/thoughtworks-test.git'  // Update with your Git repository URL
    }

    stages {
        stage('Clone Git Repository') {
            steps {
                script {
                    // Clone the Git repository containing the Dockerfile
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], userRemoteConfigs: [[url: GIT_REPO_URL]]])
                }
            }
        }

        stage('Extract Version from Dockerfile') {
            steps {
                script {
                    // Extract the version information from your Dockerfile
                    VERSION = sh(script: "grep 'LABEL version=' Dockerfile | cut -d '=' -f2", returnStdout: true).trim()
                    echo "Docker image version: ${VERSION}"
                }
            }
        }

        stage('Build and Push Docker Image5') {
            steps {
                script {
                    // Build and push your Docker image with the extracted version as the tag
                    docker.build("${DOCKER_HUB_REPO}:${VERSION}")
                    docker.withRegistry('https://hub.docker.com/repository/docker/sudharshu91/tw-ss-mediawiki/', 'docker-hub-credentials') {
                        docker.push("${DOCKER_HUB_REPO}:${VERSION}")
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Update the Kubernetes deployment with the extracted image version
                    sh "kubectl set image deployment/${K8S_DEPLOYMENT} ${K8S_DEPLOYMENT}=${DOCKER_HUB_REPO}:${VERSION} -n ${K8S_NAMESPACE}"
                }
            }
        }
    }
}
