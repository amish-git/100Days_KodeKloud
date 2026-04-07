### TASK
Earlier today, the Nautilus DevOps team deployed a new release for an application. However, a customer has reported a bug related to this recent release. Consequently, the team aims to revert to the previous version.


- There exists a deployment named **nginx-deployment**; initiate a rollback to the previous revision.


### SOLUTION

```bash
kubectl rollout undo deployment/nginx-deployment
```
Manage the rollout of resource.
```bash
kubectl rollout history - View rollout history
kubectl rollout pause - Mark the provided resource as paused
kubectl rollout restart - Restart a resource
kubectl rollout resume - Resume a paused resource
kubectl rollout status - Show the status of the rollout
kubectl rollout undo - Undo a previous rollout

usage:
# Rollback to the previous deployment
  kubectl rollout undo deployment/abc
  
  # Check the rollout status of a daemonset
  kubectl rollout status daemonset/foo
  
  # Restart a deployment
  kubectl rollout restart deployment/abc
  
  # Restart deployments with the 'app=nginx' label
  kubectl rollout restart deployment --selector=app=nginx
```