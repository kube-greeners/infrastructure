helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
helm repo add bitnami https://charts.bitnami.com/bitnami

# helm repo update
# You can't for some reason have git ignore your submodule, so we re-initialize it each time
git submodule add -f https://github.com/davidebianchi/kube-green.git kube-green
git submodule update --init

### Monitoring tooling
helm template prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring -f ./monitoring-values.yml > generated/prometheus.yml

### Some staging databases
helm template redis bitnami/redis -n staging > staging/generated/redis.yml
helm template mongodb bitnami/mongodb -n staging > staging/generated/mongo.yml

### Same, production
helm template redis bitnami/redis -n production > production/generated/redis.yml
helm template mongodb bitnami/mongodb -n production > production/generated/mongo.yml


### Apply everything :)

# There is no reason to re-deploy kube-green
# kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.0/cert-manager.yaml
# cd kube-green && make deploy && cd ..

kubectl apply -k staging
kubectl apply -k production


# If we apply the monitoring resources everything restarts from 0, so let's not do it :D.
# kubectl apply -f generated/*