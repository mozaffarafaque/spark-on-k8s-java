#!/bin/sh

set -e

cd /tmp
mkdir -p spark-build-1
cd spark-build-1
ONE=1
DOWNLOAD="--download"

if [ $# == $ONE ]
then 
    if [ $1 == $DOWNLOAD ]
    then
        echo "Downloading......"
        wget https://mirrors.estointernet.in/apache/spark/spark-3.0.1/spark-3.0.1-bin-hadoop2.7.tgz 
        tar xfvz spark-3.0.1-bin-hadoop2.7.tgz
        rm spark-3.0.1-bin-hadoop2.7.tgz
    fi
fi 
cd spark-3.0.1-bin-hadoop2.7


./bin/docker-image-tool.sh \
    -r mozafaq/spark-on-k8s \
    -t 2.0 \
    -b java_image_tag=11 \
    build



dev/make-distribution.sh -Pkubernetes -DskipTests

docker tag mozafaq/spark-on-k8s/spark:2.0 mozafaq/spark-on-k8s:2.0 


docker build -t spark-k8s:1.1 -f kubernetes/dockerfiles/spark/Dockerfile .




