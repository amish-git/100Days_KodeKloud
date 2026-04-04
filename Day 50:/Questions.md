The Nautilus DevOps team has noticed performance issues in some Kubernetes-hosted applications due to resource constraints. To address this, they plan to set limits on resource utilization. Here are the details:


Create a pod **named-pod** with a container named **httpd-containe**r. Use the httpd image with the latest tag (specify as **httpd:latest**). Set the following resource limits:

**Requests**: Memory: 15Mi, CPU: 100m

**Limits**: Memory: 20Mi, CPU: 100m

Note: The kubectl utility on the jump-host has been configured to work with the Kubernetes cluster.

### INSTRUCTIONS

```bash

vi httpd-podspecs.yaml
```


```bash
k apply -f httpd-podspec.yaml
# Verify pods are running
k get pods
k describe po httpd-pod
```