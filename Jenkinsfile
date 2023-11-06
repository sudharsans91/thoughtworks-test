pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'https://hub.docker.com/repository/docker/sudharshu91/'
        IMAGE_NAME = 'tw-ss-mediawiki'
    }

    stages {
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
}
