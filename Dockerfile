FROM google/cloud-sdk:latest

RUN apt-get install kubectl -y
RUN curl -OL https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz && tar -zxvf helm-v2.12.3-linux-amd64.tar.gz \
&& mv linux-amd64/helm /usr/local/bin/helm && rm -r helm-v2.12.3-linux-amd64.tar.gz && rm -r linux-amd64
ADD gke_bootstrap_script.sh /
ADD common.sh /
ADD run.sh /
ADD values.yaml /
# echo
#gcloud auth activate-service-account --key-file=credential_key.json
#gcloud config set project my-project
#PROJECT=$PROJECT ./gke_bootstrap_script.sh $TYPE
#helm repo add gitlab https://charts.gitlab.io
#helm repo update
#helm install --namespace gitlab-ci --name gitlab-runner-1 -f values.yaml gitlab/gitlab-runner
ENTRYPOINT ["bash"]
