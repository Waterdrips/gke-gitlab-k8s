#!/bin/bash

# Checks that appropriate gke params are set and
# that gcloud and kubectl are properly installed and authenticated

# 	Copyright (c) 2011-2017 GitLab B.V.
# 	With regard to the GitLab Software:
# 	Permission is hereby granted, free of charge, to any person obtaining a copy
# 	of this software and associated documentation files (the "Software"), to deal
# 	in the Software without restriction, including without limitation the rights
# 	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# 	copies of the Software, and to permit persons to whom the Software is
# 	furnished to do so, subject to the following conditions:
# 	The above copyright notice and this permission notice shall be included in
# 	all copies or substantial portions of the Software.
# 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# 	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# 	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# 	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# 	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# 	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# 	THE SOFTWARE.
# 	For all third party components incorporated into the GitLab Software, those
# 	components are licensed under the original license provided by the owner of the
# 	applicable component.


function validate_required_tools(){
  if [ -z "$PROJECT" ]; then
    echo "\$PROJECT needs to be set to your project id";
    exit 1;
  fi

  command -v gcloud  >/dev/null 2>&1 || { echo >&2 "gcloud is required please follow: https://cloud.google.com/sdk/downloads"; exit 1; }
  command -v kubectl >/dev/null 2>&1 || { echo >&2 "kubectl is required please follow: https://kubernetes.io/docs/tasks/tools/install-kubectl"; exit 1; }
  command -v helm    >/dev/null 2>&1 || { echo >&2 "helm is required please follow: https://github.com/kubernetes/helm/blob/master/docs/install.md"; exit 1; }

  gcloud container clusters list >/dev/null 2>&1 || { echo >&2 "Gcloud seems to be configured incorrectly or authentication is unsuccessfull"; exit 1; }

}

function cluster_admin_password_gke(){
  gcloud container clusters describe $CLUSTER_NAME --zone $ZONE --project $PROJECT --format='value(masterAuth.password)';
}
