SHELL:=/bin/bash
.SILENT:
.PHONY: help

help:
	@echo "Usage:"
	@echo "     make [command]"
	@echo
	@echo "Available commands:"
	@grep '^[^#[:space:]].*:' Makefile | grep -vE '^(default|all|help|doc)' | grep -v '^\.' | grep -v '=' | grep -v '^_' | sed 's/://' | xargs -n 1 echo ' -'

all:
	clear
	@for command in $$(grep '^[^#[:space:]].*:' Makefile | grep -vE '^(default|all|help|doc)' | grep -v '^\.' | grep -v '=' | grep -v '^_' | sed 's/://') ; do\
		echo -e "\x1b[31m$$command\x1b[0m" ;\
		$(MAKE) $$command ;\
		echo ----------------------- ;\
	done

doc:
	@lastTitle='';\
	echo "#" $$(git symbolic-ref --short HEAD | xargs | awk '{ print toupper( substr( $$0, 1, 1 ) ) substr( $$0, 2 ); }' ) ;\
	echo "" ;\
	for command in $$(grep '^[^#[:space:]].*:' Makefile | grep -vE '^(default|all|help|doc)' | grep -v '^\.' | grep -v '=' | grep -v '^_' | sed 's/://' | sort) ; do\
		title=$$(echo $$command | sed 's/-/ /g' );\
		h1=$$(echo $$title| sed -E 's/([0-9]{2})(.+)([0-9]{2})(.+)/\2/' | xargs | awk '{ print toupper( substr( $$0, 1, 1 ) ) substr( $$0, 2 ); }'  ) ;\
		h2=$$(echo $$title| sed -E 's/([0-9]{2})(.+)([0-9]{2})(.+)/\4/' | xargs | awk '{ print toupper( substr( $$0, 1, 1 ) ) substr( $$0, 2 ); }' ) ;\
		if [ "$$lastTitle" 	!= "$$h1" ]; then echo -e "## $${h1}\n" && lastTitle="$$h1" ;fi;\
		echo -e "### $${h2}\n";\
		echo -e "\`$$ make $$command\`" ; \
		code=$$($(MAKE) -n $$command) ; \
		echo -e "\n\`\`\`\n$$code\n\`\`\` \n" ; \
	done

01-kubernetes-misc-01-get-info:
	kubectl cluster-info

01-kubernetes-misc-02-switch-to-minikube:
	kubectl config use-context minikube

01-kubernetes-misc-03-display-kube-config:
	cat ~/.kube/config

01-kubernetes-misc-04-launch-proxy-in-background:
	kubectl proxy &

01-kubernetes-misc-05-create-local-registry:
	docker run -d -p 5000:5000 --restart=always --name registry registry:2

01-kubernetes-misc-06-install-k8s-dashboard:
	kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml


01-kubectl-queries-01-apply-example:
	- kubectl delete -f 01-Simple/
	kubectl apply -f 01-Simple/

01-kubectl-queries-02-get-all-pods:
	kubectl get pods

01-kubectl-queries-03-get-all-pods-all-namespace:
	kubectl get pods --all-namespaces

01-kubectl-queries-04-get-all-object:
	kubectl get all

01-kubectl-queries-05-get-pods-name:
	kubectl get pods -o name

01-kubectl-queries-06-get-pods-info-widely:
	kubectl get pods -o wide

01-kubectl-queries-07-execute-one-command-in-a-pod:
	kubectl exec nginx cat /etc/nginx/conf.d/default.conf

01-kubectl-queries-08-view-pod-metadata:
	kubectl describe pod nginx

01-kubectl-queries-09-view-pods-as-json:
	kubectl get pods --field-selector=status.phase=Running -o=json | jq

01-kubectl-queries-10-view-pods-and-format:
	kubectl get pods --field-selector=status.phase=Running -o=jsonpath='{.items[*].metadata.name}'

01-kubectl-queries-11-view-pods-as-json:
	kubectl get pods --field-selector=status.phase=Running -o=json | jq ".items[0].spec.containers"

01-kubectl-queries-12-view-pods-log:
	kubectl logs nginx -c nginx

01-kubectl-queries-13-execute-simple-http-call:
	kubectl port-forward pod/nginx 8080:80 &;kubectlPid=$!
	curl http://127.0.0.1:8080
	kill $kubectlPid

01-kubectl-queries-99-cleanup:
	- kubectl delete -f 01-Simple/
	kubectl get all


02-kubernetes-selector-01-:
	- kubectl delete -f 02-Selector/
	kubectl apply -f 02-Selector/

02-kubernetes-selector-02-label-queries:
	kubectl get all -l app=frontend
	kubectl get all -l app=backend
	kubectl get all -l service=cdn
	kubectl get all -l type=application

02-kubernetes-selector-03-extended-label-queries:
	kubectl get all -l type=application,environment=dev
	kubectl get all -l 'type notin (application)'
	kubectl get all -l 'type in (application)'
	kubectl get all -l 'type in (application),app=frontend'

02-kubernetes-selector-04-selector-for-delete:
	kubectl delete pods -l service=cdn
	kubectl get pods

02-kubernetes-selector-99-cleanup:
	- kubectl delete -f 02-Selector/
	kubectl get all


03-kubernetes-load-balancing-01-build-image:
	03-Loadbalancing/container/build.sh

03-kubernetes-load-balancing-02-apply-example:
	- kubectl delete -f 03-Loadbalancing/
	kubectl apply -f 03-Loadbalancing/
	sleep 10

03-kubernetes-load-balancing-03-access-service:
	http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/

03-kubernetes-load-balancing-04-test-load-balancing:
	http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
	http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
	http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
	http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID
	http http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/ | jq .ID

03-kubernetes-load-balancing-99-cleanup:
	- kubectl delete -f 03-Loadbalancing/
	kubectl get all
