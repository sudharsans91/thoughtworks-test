# thoughtworks-test
2

1. To deploy a MediaWiki application using Helm, you can create a Helm chart that defines the Kubernetes resources and configurations needed to run MediaWiki. Helm simplifies the deployment process by allowing you to define, package, and manage your Kubernetes application as a chart. Here are the steps to achieve this:


Create a Helm Chart:

You can create a Helm chart for deploying MediaWiki by running the following Helm command:

helm create mediawiki
This command will create a new Helm chart named "mediawiki."

Configure the Helm Chart:

Inside the mediawiki chart directory, you'll find various subdirectories and files. You need to configure the chart to deploy MediaWiki. Below is a simplified example of how to configure the chart. You may need to customize it further based on your specific requirements.

Chart.yaml: Update the metadata in the Chart.yaml file, specifying the chart name and version.

values.yaml: Customize values in the values.yaml file. For example, set the database username, password, and other MediaWiki-related settings.

templates/deployment.yaml: Create a Deployment resource for MediaWiki and define the necessary environment variables, volumes, and containers.

templates/service.yaml: Create a Service resource for accessing MediaWiki.

templates/pvc.yaml: Define a PersistentVolumeClaim if you want to use persistent storage.


Install the Helm Chart:

To install the Helm chart, run the following command in the chart's directory:

helm install my-mediawiki-release ./mediawiki
Replace my-mediawiki-release with your desired release name.

Access MediaWiki:

After the deployment is complete, you can access MediaWiki by forwarding the service's port to your local machine using kubectl port-forward. For example:

kubectl port-forward service/my-mediawiki-release-mediawiki 8080:80
You can then access MediaWiki in your web browser by visiting http://localhost:8080.

This is a simplified example of how to deploy MediaWiki using Helm. Depending on your specific requirements and infrastructure, you may need to customize the Helm chart further. Additionally, consider configuring persistent storage for your database and implementing other necessary configurations for a production-grade deployment.