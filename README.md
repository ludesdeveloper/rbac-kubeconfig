# **RBAC KUBECONFIG WITH ROLE AND CLUSTER ROLE**

<p align="center">
<img src="pic/ludes.png" width="500">
</p>

### **Brief Explanation**

You can use this script for generate kubeconfig using **role** for specific namespace or **cluster role** for cluster

### **Before You Begin**

1. Use chmod to allow execute script

```
chmod u+x *.sh
```

### **Generate Kubeconfig with Role**

1. define you USER_NAME and NAMESPACE

```
export USER_NAME=developer
export NAMESPACE=mynamespace
```

2. Create manifest

```
./create_manifest.sh
```

3. Apply to kubernetes

```
kubectl apply -f rbac_manifests.yaml
```

4. Create kubeconfig

```
./create_kubeconfig.sh
```

5. You can use new config to test

```
kubectl --kubeconfig config get pods
```

### **Generate Kubeconfig with Cluster Role**

1. define you USER_NAME

```
export USER_NAME=developer
```

2. Create manifest

```
./create_manifest_cluster_role.sh
```

3. Apply to kubernetes

```
kubectl apply -f rbac_manifests.yaml
```

4. Create kubeconfig

```
./create_kubeconfig_cluster_role.sh
```

5. You can use new config to test

```
kubectl --kubeconfig config get pods
```
