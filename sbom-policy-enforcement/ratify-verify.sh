#!/bin/zsh

# This script uses the slow() function from Brandon Mitchell available at 
# https://github.com/sudo-bmitch/presentations/blob/main/oci-referrers-2023/demo-script.sh#L23
# to simulate typing the commands

opt_a=0
opt_s=25

while getopts 'ahs:' option; do
  case $option in
    a) opt_a=1;;
    h) opt_h=1;;
    s) opt_s="$OPTARG";;
  esac
done
set +e
shift `expr $OPTIND - 1`

if [ $# -gt 0 -o "$opt_h" = "1" ]; then
  echo "Usage: $0 [opts]"
  echo " -h: this help message"
  echo " -s bps: speed (default $opt_s)"
  exit 1
fi

slow() {
  echo -n "\$ $@" | pv -qL $opt_s
  if [ "$opt_a" = "0" ]; then
    read lf
  else
    echo
  fi
}

clear
slow

slow 'oras discover -o tree kubeconeu.azurecr.io/demo-app:sha-d0992af7eb825e7ba03fd777016073c3765a1c30o'
oras discover -o tree kubeconeu.azurecr.io/demo-app:sha-d0992af7eb825e7ba03fd777016073c3765a1c30

slow 'oras manifest fetch kubeconeu.azurecr.io/demo-app@sha256:7211207ec7dc0e9605a39aecf41876af23dc29595ec5a60976ae03e178708595 | jq'
oras manifest fetch kubeconeu.azurecr.io/demo-app@sha256:7211207ec7dc0e9605a39aecf41876af23dc29595ec5a60976ae03e178708595 | jq

slow "regctl artifact get kubeconeu.azurecr.io/demo-app@sha256:7211207ec7dc0e9605a39aecf41876af23dc29595ec5a60976ae03e178708595 | jq '.packages[].licenseConcluded'"
regctl artifact get kubeconeu.azurecr.io/demo-app@sha256:7211207ec7dc0e9605a39aecf41876af23dc29595ec5a60976ae03e178708595 | jq '.packages[].licenseConcluded' | more

slow
clear

slow 'kubectl get verifiers'
kubectl get verifiers

slow
clear

slow 'cat package-verifier.yml'
cat package-verifier.yml

slow 'oras manifest fetch kubeconeu.azurecr.io/ratify/package-checker:v0.0.0-alpha.1 | jq'
oras manifest fetch kubeconeu.azurecr.io/ratify/package-checker:v0.0.0-alpha.1 | jq

slow 'kubectl apply -f package-verifier.yml'
kubectl apply -f package-verifier.yml

slow 'kubectl get verifiers'
kubectl get verifiers

slow 'kubectl run demo --image kubeconeu.azurecr.io/demo-app:sha-d0992af7eb825e7ba03fd777016073c3765a1c30'
kubectl run demo --image kubeconeu.azurecr.io/demo-app:sha-d0992af7eb825e7ba03fd777016073c3765a1c30

slow 'kubectl logs deployment/ratify -n gatekeeper-system'
kubectl logs deployment/ratify -n gatekeeper-system
