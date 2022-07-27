cat << EOF > rbac_manifests.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: ${USER_NAME} 
rules:
  - apiGroups: [""]
    resources: ["pods", "services", "namespaces", "nodes"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["pods/portforward"]
    verbs: ["create", "get", "update", "list", "delete", "watch", "patch"]
  - apiGroups: ["apps"]
    resources: ["deployments", "statefulsets", "daemonsets", "replicasets"]
    verbs: ["get", "list", "watch"]
  - apiGroups: ["rbac.authorization.k8s.io"]
    resources: ["clusterroles", "clusterrolebindings"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: ${USER_NAME} 
subjects:
  - kind: ServiceAccount
    name: ${USER_NAME}-sa
    namespace: kube-system 
roleRef:
  kind: ClusterRole 
  name: ${USER_NAME} 
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${USER_NAME}-sa 
  namespace: kube-system 
secrets:
  - name: ${USER_NAME}-secret
---
apiVersion: v1
kind: Secret
metadata:
  name: ${USER_NAME}-secret
  namespace: kube-system 
  annotations:
    kubernetes.io/service-account.name: ${USER_NAME}-sa
type: kubernetes.io/service-account-token
EOF
