
kubectl create namespace spark

kubectl create serviceaccount spark -n spark

kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=spark:spark --namespace=spark

# After applying kubectl apply command
kubectl port-forward -n spark deployment.apps/my-notebook-deployment 8888:8888
