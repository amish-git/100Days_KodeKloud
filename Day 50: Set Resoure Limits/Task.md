The Nautilus DevOps team has noticed performance issues in some Kubernetes-hosted applications due to resource constraints. To address this, they plan to set limits on resource utilization. Here are the details:


Create a pod **named-pod** with a container named **httpd-containe**r. Use the httpd image with the latest tag (specify as **httpd:latest**). Set the following resource limits:

**Requests**: Memory: 15Mi, CPU: 100m

**Limits**: Memory: 20Mi, CPU: 100m

Note: The kubectl utility on the jump-host has been configured to work with the Kubernetes cluster.

### Theory

When you specify a Pod, you can optionally specify how much of each resource a container needs i.e CPU and memory (RAM).

#### Requests and Limits
If the node where a Pod is running has enough of a resource available, it's possible (and allowed) for a container to use more resource than its request for that resource specifies.

For example, if you set a memory request of 256 MiB for a container, and that container is in a Pod scheduled to a Node with 8GiB of memory and no other Pods, then the container can try to use more RAM.

**cpu limits** are enforced by CPU throttling. When a container approaches its cpu limit, the kernel will restrict access to the CPU corresponding to the container's limit. Thus, a cpu limit is a hard limit the kernel enforces. 

**memory limits** are enforced by the kernel with out of memory (OOM) kills. When a container uses more than its memory limit, the kernel may terminate it. However, terminations only happen when the kernel detects memory pressure.

### INSTRUCTIONS

```bash
vi httpd-podspecs.yaml
```

Here is the pod definition for httpd: [httpd-pod](httpd-podspec.yaml)


```bash
k apply -f httpd-podspec.yaml
# Verify pods are running
k get pods
k describe po httpd-pod
```