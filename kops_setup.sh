#!/bin/bash
set -e

echo "root:root" | chpasswd

aws configure set aws_access_key_id "YOUR_ACCESS_KEY"
aws configure set aws_secret_access_key "YOUR_SECRET_KEY"
aws configure set default.region "ap-south-1"

export KOPS_STATE_STORE=s3://vijay.kops.v1

ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa <<< y >/dev/null 2>&1 || true

curl -Lo kops https://github.com/kubernetes/kops/releases/latest/download/kops-linux-amd64
chmod +x kops
mv kops /usr/local/bin/kops

curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl

kops create cluster \
  --name vijay.k8s.local \
  --zones ap-south-1a \
  --master-size t3.small \
  --node-size t3.small

kops update cluster \
  --name vijay.k8s.local \
  --yes \
  --admin

kops get all
