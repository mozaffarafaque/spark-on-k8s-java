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
    -t 1.0 \
    -b java_image_tag=11 \
    -u sparkusr \
    build


