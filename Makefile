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

00-docker-compose-01-up:
kubectl config use-context minikube
kubectl cluster-info
cat ~/.kube/config
kubectl proxy &
docker run -d -p 5000:5000 --restart=always --name registry registry:2
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml



00-docker-compose-01-up:
kubectl delete -f 01-Simple/
kubectl apply -f 01-Simple/
kubectl get pods
kubectl get all
kubectl get pods -o name
kubectl get pods -o wide
kubectl exec nginx cat /etc/nginx/conf.d/default.conf
kubectl describe pod nginx
kubectl get pods -o --field-selector=status.phase=Running -o=jsonpath='{.items[*].metadata.name}'
kubectl get pods -o --field-selector=status.phase=Running -o=json
kubectl logs nginx -c nginx
kubectl port-forward pod/nginx 8080:80 &;kubectlPid=$!
curl http://127.0.0.1:8080
kill $kubectlPid
kubectl delete -f 01-Simple/
kubectl get all


kubectl delete -f 02-Selector/
kubectl apply -f 02-Selector/
kubectl get all -l app=frontend
kubectl get all -l app=backend
kubectl get all -l service=cdn
kubectl get all -l type=application
kubectl get all -l type=application,environment=dev
kubectl get all -l 'type notin (application)'
kubectl get all -l 'type in (application)'
kubectl get all -l 'type in (application),app=frontend'
kubectl delete pods -l service=cdn\n
kubectl get pods
kubectl delete -f 02-Selector/
kubectl get all


03-Loadbalancing/container/build.sh
kubectl delete -f 03-Loadbalancing/
kubectl apply -f 03-Loadbalancing/
curl http://localhost:8001/api/v1/namespaces/default/services/http:frontend-service:web/proxy/
