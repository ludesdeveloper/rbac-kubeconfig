cat << EOF > rbac_manifests.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: ${USER_NAME} 
  namespace: ${NAMESPACE}
rules:
  - apiGroups: [""]
    resources: ["pods", "services", "namespaces", "nodes"]
    verbs: ["create", "get", "update", "list", "watch", "patch"]
  - apiGroups: ["apps"]
    resources: ["deployment"]
    verbs: ["create", "get", "update", "list", "delete", "watch", "patch"]
  - apiGroups: ["rbac.authorization.k8s.io"]
    resources: ["clusterroles", "clusterrolebindings"]
    verbs: ["create", "get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ${USER_NAME} 
  namespace: ${NAMESPACE} 
subjects:
  - kind: ServiceAccount
    name: ${USER_NAME}-sa
    namespace: ${NAMESPACE} 
roleRef:
  kind: Role
  name: ${USER_NAME} 
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${USER_NAME}-sa 
  namespace: ${NAMESPACE} 
secrets:
  - name: ${USER_NAME}-secret
---
apiVersion: v1
kind: Secret
metadata:
  name: ${USER_NAME}-secret
  namespace: ${NAMESPACE} 
  annotations:
    kubernetes.io/service-account.name: ${USER_NAME}-sa
type: kubernetes.io/service-account-token
EOF
