# Spark setup

## Create service accounts and role

```

kubectl create serviceaccount spark -n spark

kubectl create clusterrolebinding spark-role --clusterrole=edit  --serviceaccount=default:spark --namespace=default

```

### For console (if required)

```
kubectl port-forward -n spark deployment.apps/afaque-spark-deployment 8888:8888
```


Node: Image needs to be pullled on each worker node and master node


### Run pi job

```
bin/spark-submit \
--master k8s://https://172.31.80.10:6443 \
--deploy-mode cluster \
--name spark-pi \
--class org.apache.spark.examples.SparkPi \
--conf spark.executor.instances=2 \
--conf spark.kubernetes.container.image=mozafaq/spark-on-k8s:3.1 \
--conf spark.kubernetes.container.image.pullPolicy=Never \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
local:///opt/spark/examples/jars/spark-examples_2.12-3.1.1-SNAPSHOT.jar 100000

```
### Notes in above command
  - https://172.31.80.10:6443: was received after executing cluster info
  - mozafaq/spark-on-k8s:3.1: is image
  - spark: this related to service account: Needs to be pulled on each nodes (master + workers)
  - /opt/spark/examples/jars/spark-examples_2.12-3.1.1-SNAPSHOT.jar: Location of jar - actual jar name may vary dependingnon the spark version used
  - 100000: is the number of iterations, you can change it.