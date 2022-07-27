```
chmod u+x *.sh
```

```
export USER_NAME=developer
export NAMESPACE=mynamespace
```

```
./create_manifest.sh
kubectl apply -f rbac_manifests.yaml
./create_kubeconfig.sh
```

```
kubectl --kubeconfig config get pods
```
