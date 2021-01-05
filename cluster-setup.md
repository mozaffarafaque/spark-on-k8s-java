https://linuxconfig.org/how-to-install-kubernetes-on-ubuntu-20-04-focal-fossa-linux


https://www.linuxtechi.com/install-kubernetes-k8s-on-ubuntu-20-04/


Commands

    1  sudo apt update
    2  sudo apt -y upgrade && sudo systemctl reboot
    3  sudo apt install docker.io
    4  java-version
    5  java -version
    6  df -kh .
    7  hostname
    8  sudo kubeadm init
    9  cat \$HOME/.kube/config 
   10  cat ~/.kube/config 
   11  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
   12  echo $?
   13  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
   14  kubectl get pods --all-namespaces
   15  kubectl get deployments --all-namespaces
   16  kubectl get pods  --all-namespaces
   17  kubeadm token create --print-join-command
   18  kubectl get pods  --all-namespaces
   19  net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
   20  kubectl cluster-info
   21  kubectl get nodes
   22  kubectl cluster-info
   23  kubectl get pods  --all-namespaces
   24  mkdir tmp
   25  cd tmp/
   26  ls -l
   27  vim image-build.sh
   28  cd  ..
   29  cd sp
   30  ls -l
   31  mv tmp/ codebase/
   32  cd codebase/
   33  ls -l
   34  cd spark/
   35  ls -l
   36  chmod +x ../tmp/image-build.sh 
   37  ../tmp/image-build.sh 
   38  ../tmp/image-build.sh 3.1
   39  vim ../tmp/image-build.sh 
   40  ../tmp/image-build.sh 3.1
   41  docker push mozafaq/spark-on-k8s:3.1
   42  git clone https://github.com/mozaffarafaque/spark-on-k8s-java.git
   43  ls -l
   44  rm -rf spark-on-k8s-java
   45  cd ..
   46  git clone https://github.com/mozaffarafaque/spark-on-k8s-java.git
   47  cd spark-on-k8s-java/
   48  cd k8s/
   49  ls -l
   50  kubectl create namespace spark
   51  kubectl create serviceaccount spark -n spark
   52  kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=spark:spark --namespace=spark
   53  cd ..
   54  git pull
   55  kubectl apply -f k8s/
   56  kubectl get pods
   57  kubectl get pods -n=spark
   58  kubectl get service -n=spark
   59  kubectl get services -n=spark
   60  less k8s/spark-k8s-service.yaml 
   61  kubectl get services -n=default
   62  kubectl delete  services afaque-spark-service -n=default
   63  kubectl delete deployments afaque-spark-deployment  -n=spark
   64  kubectl cluster-info
   65  cd ..
   66  cd spark
   67  find . -name spark-examples_2.12-3.1.0-SNAPSHOT.jar
   68  ls -l
   69  du -sh .
   70  find examples -name spark-examples_2.12-3.1.0-SNAPSHOT.jar
   71  find examples -name spark-examples_2.12-*
   72  bin/spark-submit --master k8s:// https://172.31.80.10:6443 --deploy-mode cluster --name spark-pi --class org.apache.spark.examples.SparkPi --conf spark.executor.instances=2 --conf spark.kubernetes.container.image=mozafaq/spark-k8s:3.1 --conf spark.kubernetes.container.image.pullPolicy=Never --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark local:///opt/spark/examples/jars/spark-examples_2.12-3.1.1-SNAPSHOT.jar 100000
   73  bin/spark-submit --master k8s:// http://172.31.80.10:6443 --deploy-mode cluster --name spark-pi --class org.apache.spark.examples.SparkPi --conf spark.executor.instances=2 --conf spark.kubernetes.container.image=mozafaq/spark-k8s:3.1 --conf spark.kubernetes.container.image.pullPolicy=Never --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark local:///opt/spark/examples/jars/spark-examples_2.12-3.1.1-SNAPSHOT.jar 100000
   74  bin/spark-submit --master k8s://https://172.31.80.10:6443 --deploy-mode cluster --name spark-pi --class org.apache.spark.examples.SparkPi --conf spark.executor.instances=2 --conf spark.kubernetes.container.image=mozafaq/spark-k8s:3.1 --conf spark.kubernetes.container.image.pullPolicy=Never --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark local:///opt/spark/examples/jars/spark-examples_2.12-3.1.1-SNAPSHOT.jar 100000
   75  kubectl get pods -n=spark
   76  kubectl get deployments --all-namespace
   77  kubectl get deployments --all-namespaces
   78  kubectl get pods --all-namespaces
   79* kubectl get se --all-namespaces
   80  kubectl get namespaces
   81  kubectl get accounts
   82  kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=spark
   83  kubectl get clusterrolebinding
   84  kubectl get accounts | grep spark
   85  kubectl get clusterrolebinding | grep spark
   86  kubectl delete  clusterrolebinding  spark-role
   87  kubectl create clusterrolebinding spark-role --clusterrole=edit  --serviceaccount=default:spark --namespace=default
   88  bin/spark-submit --master k8s://https://172.31.80.10:6443 --deploy-mode cluster --name spark-pi --class org.apache.spark.examples.SparkPi --conf spark.executor.instances=2 --conf spark.kubernetes.container.image=mozafaq/spark-k8s:3.1 --conf spark.kubernetes.container.image.pullPolicy=Never --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark local:///opt/spark/examples/jars/spark-examples_2.12-3.1.1-SNAPSHOT.jar 100000
   89  kubectl get serviceaccounts
   90  kubectl create serviceaccount spark
   91  bin/spark-submit --master k8s://https://172.31.80.10:6443 --deploy-mode cluster --name spark-pi --class org.apache.spark.examples.SparkPi --conf spark.executor.instances=2 --conf spark.kubernetes.container.image=mozafaq/spark-k8s:3.1 --conf spark.kubernetes.container.image.pullPolicy=Never --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark local:///opt/spark/examples/jars/spark-examples_2.12-3.1.1-SNAPSHOT.jar 100000
   92  kubectl get pods
   93  kubectl delete pods spark-pi-50919676d3d2e8ab-driver
   94  docker container run -it -d  --name container-k8s-spark mozafaq/spark-k8s:3.1 /bin/bash
   95  history
