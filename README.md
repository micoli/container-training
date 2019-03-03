# 10-Kubernetes

## Kubectl queries

### Apply example

`$ make 01-kubectl-queries-01-apply-example`

```
kubectl delete -f 01-Simple/
kubectl apply -f 01-Simple/
``` 

### Get all pods

`$ make 01-kubectl-queries-02-get-all-pods`

```
kubectl get pods
``` 

### Get all pods all namespace

`$ make 01-kubectl-queries-03-get-all-pods-all-namespace`

```
kubectl get pods --all-namespaces
``` 

### Get all object

`$ make 01-kubectl-queries-04-get-all-object`

```
kubectl get all
``` 

### Get pods name

`$ make 01-kubectl-queries-05-get-pods-name`

```
kubectl get pods -o name
``` 

### Get pods info widely

`$ make 01-kubectl-queries-06-get-pods-info-widely`

```
kubectl get pods -o wide
``` 

### Execute one command in a pod

`$ make 01-kubectl-queries-07-execute-one-command-in-a-pod`

```
kubectl exec nginx cat /etc/nginx/conf.d/default.conf
``` 

### View pod metadata

`$ make 01-kubectl-queries-08-view-pod-metadata`

```
kubectl describe pod nginx
``` 

### View pods as json

`$ make 01-kubectl-queries-09-view-pods-as-json`

```
kubectl get pods --field-selector=status.phase=Running -o=json | jq
``` 

### View pods and format

`$ make 01-kubectl-queries-10-view-pods-and-format`

```
kubectl get pods --field-selector=status.phase=Running -o=jsonpath='{.items[*].metadata.name}'
``` 

### View pods as json

`$ make 01-kubectl-queries-11-view-pods-as-json`

```
kubectl get pods --field-selector=status.phase=Running -o=json | jq ".items[0].spec.containers"
``` 

### View pods log

`$ make 01-kubectl-queries-12-view-pods-log`

```
kubectl logs nginx -c nginx
``` 

### Execute simple http call

`$ make 01-kubectl-queries-13-execute-simple-http-call`

```
kubectl port-forward pod/nginx 8080:80 &;kubectlPid=
curl http://127.0.0.1:8080
kill ubectlPid
``` 

### Cleanup

`$ make 01-kubectl-queries-99-cleanup`

```
kubectl delete -f 01-Simple/
kubectl get all
``` 

## Kubernetes misc

### Get info

`$ make 01-kubernetes-misc-01-get-info`

```
kubectl cluster-info
``` 

### Switch to minikube

`$ make 01-kubernetes-misc-02-switch-to-minikube`

```
kubectl config use-context minikube
``` 

### Display kube config

`$ make 01-kubernetes-misc-03-display-kube-config`

```
cat ~/.kube/config
``` 

### Launch proxy in background

`$ make 01-kubernetes-misc-04-launch-proxy-in-background`

```
kubectl proxy &
``` 

### Create local registry

`$ make 01-kubernetes-misc-05-create-local-registry`

```
docker run -d -p 5000:5000 --restart=always --name registry registry:2
``` 

### Install k8s dashboard

`$ make 01-kubernetes-misc-06-install-k8s-dashboard`

```
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
``` 

## 02 kubernetes selector 01

### 02 kubernetes selector 01

`$ make 02-kubernetes-selector-01-`

```
kubectl delete -f 02-Selector/
kubectl apply -f 02-Selector/
``` 

## Kubernetes selector

### Label queries

`$ make 02-kubernetes-selector-02-label-queries`

```
kubectl get all -l app=frontend
kubectl get all -l app=backend
kubectl get all -l service=cdn
kubectl get all -l type=application
``` 

### Extended label queries

`$ make 02-kubernetes-selector-03-extended-label-queries`

```
kubectl get all -l type=application,environment=dev
kubectl get all -l 'type notin (application)'
kubectl get all -l 'type in (application)'
kubectl get all -l 'type in (application),app=frontend'
``` 

### Selector for delete

`$ make 02-kubernetes-selector-04-selector-for-delete`

```
kubectl delete pods -l service=cdn
kubectl get pods
``` 

### Cleanup

`$ make 02-kubernetes-selector-99-cleanup`

```
kubectl delete -f 02-Selector/
kubectl get all
``` 

## Kubernetes load balancing

### Build image

`$ make 03-kubernetes-load-balancing-01-build-image`

```
03-Loadbalancing/container/build.sh
``` 

### Apply example

`$ make 03-kubernetes-load-balancing-02-apply-example`

```
kubectl delete -f 03-Loadbalancing/
kubectl apply -f 03-Loadbalancing/
sleep 10
``` 

### Access service

`$ make 03-kubernetes-load-balancing-03-access-service`

```
http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/
``` 

### Test load balancing

`$ make 03-kubernetes-load-balancing-04-test-load-balancing`

```
http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
``` 

### Cleanup

`$ make 03-kubernetes-load-balancing-99-cleanup`

```
kubectl delete -f 03-Loadbalancing/
kubectl get all
``` 

