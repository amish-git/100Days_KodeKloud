The Nautilus DevOps team is delving into Kubernetes for app management. One team member needs to create a deployment following these details:


Create a deployment named httpd to deploy the application httpd using the image httpd:latest (ensure to specify the tag)

Note: The kubectl utility on the jump-host has been configured to work with the Kubernetes cluster.

```bash
# Using a YAML file
vi nginx-deployment.yaml

#Apply it to the cluster:

kubectl apply -f nginx-deployment.yaml


#Check if it’s running:

kubectl get deployments
kubectl get pods
```