# Setting up K8S with port

sudo -S dockerd &

minikube start idp

# Install crossplane
helm repo add crossplane-stable https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace --wait

kubectl get namespace

# Install arcgocd

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl get pods -n argocd



# ArgoCD comes with a default user: admin  GBaacCw8mKIoRNM9

# To get the password, type the command below:

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


#To access the UI, Kubectl port-forwarding can also be used to connect to the API server without exposing the service.

kubectl port-forward svc/argocd-server -n argocd 8080:443

# The API server can then be accessed using https://localhost:8080



# Integrate port
helm repo add --force-update port-labs https://port-labs.github.io/helm-charts

helm upgrade --install idp port-labs/port-k8s-exporter \
--create-namespace --namespace port-k8s-exporter \
--set secret.secrets.portClientId="tKCW8Iaa2ABUgFjMkvzuIuyMtW6lDe0C"  \
--set secret.secrets.portClientSecret="jqPQfbN8wwpb0D69wH94pBSS1fBcBX1msCsEcd9rvPHDTsKWeYWxrQSprKp1LhKQ"  \
--set portBaseUrl="https://api.getport.io"  \
--set stateKey="idp"  \
--set integration.eventListener.type="POLLING"  \
--set "extraEnv[0].name"="CLUSTER_NAME"  \
--set "extraEnv[0].value"="idp" 




###########
You can encode these values using `echo -n ‘value’ | base64`.