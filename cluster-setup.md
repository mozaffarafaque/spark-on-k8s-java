# Kubernetes Setup on Ubuntu 20.04 LTS

## Summary

This explains the k8s cluster setup on ubuntu

### Reference documents
 - https://linuxconfig.org/how-to-install-kubernetes-on-ubuntu-20-04-focal-fossa-linux
 - https://www.linuxtechi.com/install-kubernetes-k8s-on-ubuntu-20-04/


## General setup

### On each Nodes (Master and Wrokers)

```
   sudo apt update
   sudo apt -y upgrade && sudo systemctl reboot
   sudo apt install docker.io
```

 Java installation

Additional ones like git culr if required




## Specific settings

### Master 

```
   sudo kubeadm init --pod-network-cidr=10.244.0.0/16

    rm -rf  $HOME/.kube
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

   kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
   kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
```

Just to chek if everyting is fine  

``` 
   kubectl get pods --all-namespaces
   kubectl get deployments --all-namespaces
   kubectl get nodes
   kubectl cluster-info
 
```

### Workers to join cluster

First execute below on master

```
kubeadm token create --print-join-command
```

The command will be printed. Copy the command and execute on worker node that needs to join the cluster

- Execute on workers as `sudo`

Example:

```
sudo kubeadm join 172.31.80.10:6443 --token 7lux2p.808mhjv26gini5hv --discovery-token-ca-cert-hash sha256:a864cd3513d8d0649426830e7d41d192358119d451b51dbbeacc11d3d3cc14e2
```

Below should report all the worker nodes along with master

```
   kubectl get nodes
```


# Fresh from the start


This document is all about the installation and cluster setup of kubernettes cluster 
on ubuntu

##  General setup

sudo apt update
sudo apt -y upgrade && sudo systemctl reboot
sudo apt install openjdk-11-jdk
sudo apt install vim git maven curl

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




## Mast Wrorker specific configurations

### Master

Set name of the host
```
sudo hostnamectl set-hostname test-k8s-master
```

```
sudo kubeadm init
```

Output from above command

```
.....
.....
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.80.10:6443 --token gkgnrm.z8h7dwqaui55okyz \
    --discovery-token-ca-cert-hash sha256:dcff06ba282a079cf0e606223883536b95eff73b9af7a5b0de9229b7cb638db5 
```

Run Below commands for actual start of nodes

```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```


### Create pod network master

```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

```

### Worker

Set name of the host

```
sudo hostnamectl set-hostname test-k8s-worker-1
```


Join master node by executing the command that was received in the output after execiting init on master

### Note
If running on AWS then make sure that they are having the security group correctly set so that they are reachable

Example

```
sudo kubeadm join 172.31.80.10:6443 --token gkgnrm.z8h7dwqaui55okyz \
    --discovery-token-ca-cert-hash sha256:dcff06ba282a079cf0e606223883536b95eff73b9af7a5b0de9229b7cb638db5
```


## Build
git checkout branch-3.1
dev/make-distribution.sh -Pkubernetes
