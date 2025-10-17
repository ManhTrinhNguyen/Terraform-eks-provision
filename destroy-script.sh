helm uninstall ingress-controller

helm uninstall mysql 

helm uninstall prometheus -n monitoring 

kubectl delete deployment java-app 

kubectl delete svc java-svc 

terraform destroy --auto-approve

