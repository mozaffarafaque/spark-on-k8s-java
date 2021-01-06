# Kubernetes Setup on Ubuntu 20.04 LTS

## Summary

This explains the k8s cluster setup on ubuntu. This document is all about the installation and cluster setup of kubernettes cluster.

### Reference documents
 - https://linuxconfig.org/how-to-install-kubernetes-on-ubuntu-20-04-focal-fossa-linux
 - https://www.linuxtechi.com/install-kubernetes-k8s-on-ubuntu-20-04/


## General setup

### On each Nodes (Master and Wrokers)

```
sudo apt update
sudo apt -y upgrade && sudo systemctl reboot
sudo apt install openjdk-11-jdk
sudo apt install vim git maven curl

```

## Docker installation

sudo apt install docker.io
sudo usermod -aG docker ubuntu
sudo chmod 666 /var/run/docker.sock
sudo service docker start
docker version
sudo systemctl enable docker

## Kubernettes installation
sudo apt install apt-transport-https 


### Note Swap off
To disable swap, edit /etc/fstab file and comment out the line which includes entry either swap partition or swap file.

Inside this file, comment out the /swapfile line by preceeding it with a # symbol, as seen below. Then, close this file and save the changes.


### For Immediate effect
sudo swapoff -a


### Note
To enable the ip forwarding permanently, edit the file “/etc/sysctl.conf” and look for line “net.ipv4.ip_forward=1” and un-comment it. After making the changes in the file, execute the following command

After above - following steps

```
$ sudo sysctl -p
net.ipv4.ip_forward = 1
$
```

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update
sudo apt install -y kubelet kubeadm kubectl

sudo apt install -y kubernetes-cni


## Specific settings

### Master 

Set name of the host
```
sudo hostnamectl set-hostname test-k8s-master
```


```
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16

  rm -rf  $HOME/.kube
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
```


Just to check if everyting is fine  

``` 
  kubectl get pods --all-namespaces
  kubectl get deployments --all-namespaces
  kubectl get nodes
  kubectl cluster-info
```

### Workers to join cluster

Set name of the host

```
sudo hostnamectl set-hostname test-k8s-worker-1
```

First execute below on master

```
kubeadm token create --print-join-command
```


#### Note
If running on AWS then make sure that they are having the security group correctly set so that they are reachable

The command will be printed. Copy the command and execute on worker node that needs to join the cluster

- Execute on workers as `sudo`

Example:

```
sudo kubeadm join 172.31.80.10:6443 --token 7lux2p.808mhjv26gini5hv --discovery-token-ca-cert-hash sha256:a864cd3513d8d0649426830e7d41d192358119d451b51dbbeacc11d3d3cc14e2
```

Below should report all the worker nodes along with `master`

```
   kubectl get nodes
```