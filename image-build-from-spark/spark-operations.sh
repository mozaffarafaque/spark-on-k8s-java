
kubectl create namespace spark

kubectl create serviceaccount spark -n spark

kubectl create clusterrolebinding spark-role --clusterrole=edit  --serviceaccount=default:spark --namespace=default

# After applying kubectl apply command
#kubectl port-forward -n spark deployment.apps/afaque-spark-deployment 8888:8888


bin/spark-submit \
--master k8s:// https://172.31.80.10:6443 \
--deploy-mode cluster \
--name spark-pi \
--class org.apache.spark.examples.SparkPi \
--conf spark.executor.instances=2 \
--conf spark.kubernetes.container.image=mozafaq/spark-k8s:3.1 \
--conf spark.kubernetes.container.image.pullPolicy=Never \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
local:///opt/spark/examples/jars/spark-examples_2.12-3.1.1-SNAPSHOT.jar 100000
