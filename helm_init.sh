helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update

### Monitoring tooling
# helm template prometheus prometheus-community/prometheus -n monitoring > generated/prometheus.yml
helm template prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring > generated/prometheus.yml

# Alert manager
# export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=alertmanager" -o jsonpath="{.items[0].metadata.name}")
# kubectl --namespace monitoring port-forward $POD_NAME 9093

# Prometheus server
# export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
# kubectl --namespace monitoring port-forward $POD_NAME 9090

# Push Gateway
# export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
# kubectl --namespace monitoring port-forward $POD_NAME 9091

### Some staging databases
helm template redis bitnami/redis -n staging > staging/generated/redis.yml
helm template mongodb bitnami/mongodb -n staging > staging/generated/mongo.yml

### Same, production
helm template redis bitnami/redis -n production > production/generated/redis.yml
helm template mongodb bitnami/mongodb -n production > production/generated/mongo.yml
###
###

### If all is well run:
# kubectl apply -k staging/kustomization.yml