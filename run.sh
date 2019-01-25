var=$(cat <<EOF
{
  "type": "service_account",
  "project_id": "${PROJECT}",
  "private_key_id": "${KEY_ID}",
  "private_key": "${KEY}",
  "client_email": "${CLIENT_EMAIL}",
  "client_id": "${CLIENT_ID}",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "${CLIENT_X_CERT_URL}"
}
EOF
)
echo $var > credential_key.json
gcloud auth activate-service-account --key-file=credential_key.json
gcloud config set project ${PROJECT}
./gke_bootstrap_script.sh ${TYPE}

if [ ${TYPE} == "up" ]
then
    helm repo add gitlab https://charts.gitlab.io
    helm repo update
    helm install --namespace gitlab-ci --name gitlab-runner -f values.yaml gitlab/gitlab-runner
else
  echo "DONE"
fi

