# Automated spinup of k8s on GCP and linking to Gitlab-CI

> docker image available from dockerhub: heyal/k8s-controller:latest

### Need to set these env vars at the least:
The ones available from GCP as a download are found in  

>IAM&Admin - Service Account - Create key

\
\
\
`PROJECT`=[From your GCP project] 

`KEY_ID`=[from GCP profile download]

`KEY`=[from GCP profile download]

`CLIENT_EMAIL`=[from GCP profile download]

`CLIENT_ID`=[from GCP profile download]

`CLIENT_X_CERT_URL`=[from GCP profile download]

`TYPE`=[down/up]

`GITLAB_REGISTRATION_TOKEN`=[value from your gitlab/settings/ci registration token]

`GITLAB_URL`=[https://gitlab.com, or your gitlab instance url]


### Available Env Vars to tune the cluster/properties:
`REGION` default us-central1

`ZONE_EXTENSION` default b

`CLUSTER_NAME` default gitlab-cluster

`MACHINE_TYPE` default n1-standard-4

`RBAC_ENABLED` default true

`NUM_NODES` default 2

`PREEMPTIBLE` default false

`EXTRA_CREATE_ARGS` default ""

`USE_STATIC_IP` default false


### Example run command:
```
docker run -i \
    -e "PROJECT=<PROJECT_ID>" \
    -e "KEY_ID=<KEY_ID_FROM_GCP_credentials>" \
    -e "KEY=<KEY_FROM_GCP>" \
    -e "CLIENT_EMAIL=<EMAIL_FROM_GCP_CREDS>" \
    -e "CLIENT_ID=<CLIENT_FROM_GCP_CREDS>" \
    -e "CLIENT_X_CERT_URL=<XCERT_URL_FROM_GCP_CREDS" \
    -e "TYPE=[down/up]" \
    -e "GITLAB_REGISTRATION_TOKEN=<GITLAB_REGISTRATION_TOKEN>" \
    -e "GITLAB_URL=<URL_FOR_YOUR_GITLAB_INSTANCE>" \
heyal/k8s-controller:latest run.sh
```


### Building the docker container:

`docker build -t <your_docker_repo>:tagname .`

`docker push <your_docker_repo>:tagname`
