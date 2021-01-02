# spark-on-k8s-java
Spark running kubernetes Java applilcation


# Building image

```
cd docker

docker build -t spark-java:latest  -f spark-java.docker .
```

Stopping container if already running and ssh into it

```
docker kill spark-app; docker rm spark-app; 
docker container run -it -d --name spark-app spark-java:latest
docker exec -it spark-app  /bin/bash
```