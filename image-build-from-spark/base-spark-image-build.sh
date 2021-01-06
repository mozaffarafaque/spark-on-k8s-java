if [ $# -ne 1 ]
then
   echo "Please pass tag  also."
   exit 1
fi

cd dist 
docker build -t mozafaq/spark-on-k8s:$1 -f kubernetes/dockerfiles/spark/Dockerfile .
