***Creating an Azure Kubernetes Service (AKS) using Terraform and an Azure DevOps pipeline***

*Prerequisites:*

1. An Azure subscription.
2. An Azure DevOps organization and project.
3. Install Terraform and the Azure CLI on your local development machine.
4. Set up Azure Service Principal:

Create an Azure Service Principal and assign the necessary permissions to it. You can do this through the Azure CLI or Azure Portal.
Configure Azure DevOps:

Create a new Azure DevOps project if you haven't already.
Set up a Service Connection to link your Azure DevOps project to your Azure subscription. Use the Service Principal created in step 2.
Initialize a Git Repository:

Create a Git repository in your Azure DevOps project where you'll store your Terraform code.
Create the Terraform Configuration:

Create a Terraform configuration that defines your AKS cluster. You'll need to include resources like a Resource Group, AKS Cluster, and optionally other Azure resources.
Ensure you use the AzureRM provider for Terraform to interact with Azure.
Store Terraform State:

Use a remote backend for storing Terraform state, such as Azure Storage or Azure Remote Backend in Terraform Cloud. This is crucial for state management in a multi-user environment.
Create an Azure DevOps Pipeline:

In your Azure DevOps project, create a new pipeline and choose the repository where your Terraform code is stored.
Configure Pipeline Variables:

Set up pipeline variables for sensitive information such as the Azure Service Principal credentials, resource group name, and other configuration variables.
Create Pipeline Stages:

Create pipeline stages in your Azure DevOps pipeline. Here's a simple example of stages you might include:
Initialize: Initialize Terraform and install necessary dependencies.
Plan: Run terraform plan to preview the changes to be applied.
Apply: If the plan looks good, run terraform apply to create or update the AKS cluster.
Deploy Application: Deploy your application to the AKS cluster using kubectl or other deployment tools.

############################################################

To create a Docker image for MediaWiki, we can use a Dockerfile. MediaWiki is a web application that requires a web server and a database, Apache and MySQL.

Dockerfile does the following:

It starts with the official PHP image with Apache as the base image.

Sets environment variables for the MediaWiki version and installation path.

Installs system dependencies and PHP extensions required for MediaWiki to function properly.

Downloads and extracts the MediaWiki source code to the specified installation path.

Configures Apache, enabling the rewrite module and setting permissions on the MediaWiki files.

Exposes port 80 to allow access to the web server.

Defines the default command to start Apache.

You can build this Docker image using the docker build command:

docker build -t mediawiki-image .

After building the image, you can create a container from it and link it to a MySQL database container or use a MySQL container.

##########################################################

MediaWiki Docker image in your Docker Hub account, you can deploy it to your existing AKS cluster by creating a Kubernetes deployment and service. Here's how to do it:

Step 1: Authenticate with Docker Hub

Before you can deploy the Docker image from your Docker Hub account, you need to authenticate with Docker Hub on your AKS cluster. You can use Kubernetes secrets to store your Docker Hub credentials securely.

Create a Docker Hub secret:

Step 2: Create a Kubernetes Deployment

Create a Kubernetes deployment YAML file for your MediaWiki application. Replace your-image-name with the name of your MediaWiki Docker image on Docker Hub.

Apply the deployment to create the MediaWiki pod:

kubectl apply -f mediawiki-deployment.yaml
Step 3: Create a Kubernetes Service

Create a Kubernetes service YAML file to expose the MediaWiki deployment:

Apply the service definition to create a LoadBalancer service:

kubectl apply -f mediawiki-service.yaml
It may take some time for the LoadBalancer service to provision an external IP address.

Step 4: Access MediaWiki

Once the external IP address is available, you can access your MediaWiki application by navigating to http://<external-ip> in your web browser.

#########################################################

To update a deployment running in Azure AKS (Azure Kubernetes Service) using a custom Docker image from your own Docker Hub registry using a Jenkins pipeline, you can follow these steps:

Set Up Prerequisites:

Ensure you have an Azure AKS cluster up and running.
Make sure you have a Docker image of your application hosted in your Docker Hub registry.
Set up Jenkins with the necessary plugins (such as Docker, Azure Credentials, Kubernetes, etc.).
Create a Jenkins Pipeline:
Create a Jenkins pipeline script for the deployment update. You can use a Jenkinsfile for this purpose. Here's an example Jenkinsfile:

pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS = credentials('your-azure-credentials-id')
        DOCKER_HUB_CREDENTIALS = credentials('your-docker-hub-credentials-id')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Update AKS Deployment') {
            steps {
                script {
                    def image = 'your-docker-hub-username/your-image-name:latest'
                    def appName = 'your-application-name'
                    def resourceGroupName = 'your-resource-group-name'
                    def aksClusterName = 'your-aks-cluster-name'
                    def deploymentName = 'your-deployment-name'

                    withCredentials([azureServicePrincipal(credentialsId: 'your-azure-credentials-id', variable: 'AZURE_CREDENTIALS')]) {
                        sh """
                        az aks get-credentials --resource-group $resourceGroupName --name $aksClusterName
                        kubectl set image deployment/$deploymentName $appName=$image
                        kubectl rollout status deployment/$deploymentName
                        """
                    }
                }
            }
        }
    }
}
In this Jenkinsfile:

Replace your-azure-credentials-id with the ID of your Azure service principal credentials stored in Jenkins.
Replace your-docker-hub-credentials-id with the ID of your Docker Hub credentials stored in Jenkins.
Modify other variables like your-docker-hub-username, your-image-name, your-application-name, your-resource-group-name, your-aks-cluster-name, and your-deployment-name to match your specific setup.
Configure Jenkins Job:

Create a new Jenkins job and select "Pipeline" as the job type.
Configure your job to use the Jenkinsfile you created in the previous step.
Build and Trigger:

Build and trigger the Jenkins job. It will update the deployment in your Azure AKS cluster with the new Docker image from your Docker Hub registry.
This pipeline script assumes you have already authenticated to Azure and Docker Hub using the provided credentials in Jenkins. Make sure your AKS cluster and AKS credentials are correctly set up before running the pipeline.

Remember to adapt the script to your specific deployment and environment, and ensure that the necessary plugins and dependencies are installed in your Jenkins instance.
