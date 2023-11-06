pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'https://hub.docker.com/repository/docker/sudharshu91/'
        IMAGE_NAME = 'tw-ss-mediawiki'
    }
/*
    stages {
        stage('Check for New Docker Image') {
            steps {
                script {
                    // Pull the latest image tags from Docker Hub
                    def dockerHubTags = sh(script: "curl -s https://registry.hub.docker.com/v2/repositories/${DOCKER_REGISTRY}/${IMAGE_NAME}/tags/?page_size=1000 | jq -r '.results[].name'", returnStdout: true).trim()
                    def latestImageTag = 'latest' // The default "latest" tag

                    if (dockerHubTags.contains('latest')) {
                        // Check if the "latest" tag is in the list
                        latestImageTag = 'latest'
                    } else {
                        // If "latest" tag is not found, use the latest tag available
                        latestImageTag = dockerHubTags.tokenize().last()
                    }

                    def currentImageTag = sh(script: "kubectl get deployment/your-deployment-name -n your-namespace -o jsonpath='{.spec.template.spec.containers[0].image}'", returnStdout: true).trim()

                    if (latestImageTag != currentImageTag) {
                        currentBuild.result = 'SUCCESS'
                    } else {
                        currentBuild.result = 'ABORTED'
                    }
                }
            }
        }
*/
        stage('Deploy to AKS') {
            steps {
                script {
                    withKubeConfig(
                        credentialsId: 'kube-config',
                    ) {
                        sh "kubectl set image deployment/your-deployment-name your-container-name=${DOCKER_REGISTRY}/${IMAGE_NAME}:${latestImageTag} -n your-namespace"
                    }
                }
            }
        }
    }

