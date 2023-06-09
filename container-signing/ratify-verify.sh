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

slow 'oras manifest fetch kubeconeu.azurecr.io/demo-app@sha256:c16e3fb2d6829f7acebae7fb38736ef188ffdfe282ca84ed538925d06da87490 | jq'
oras manifest fetch kubeconeu.azurecr.io/demo-app@sha256:c16e3fb2d6829f7acebae7fb38736ef188ffdfe282ca84ed538925d06da87490 | jq

slow
clear

slow 'notation verify --help'
notation verify --help

slow 'cat ~/Library/Application\ Support/notation/trustpolicy.json'
cat ~/Library/Application\ Support/notation/trustpolicy.json

slow
clear

slow 'notation verify kubeconeu.azurecr.io/demo-app:sha-d0992af7eb825e7ba03fd777016073c3765a1c30'
notation verify kubeconeu.azurecr.io/demo-app:sha-d0992af7eb825e7ba03fd777016073c3765a1c30

slow 'notation verify wabbitnetworks.azurecr.io/test/notary-image:unsigned'
notation verify wabbitnetworks.azurecr.io/test/notary-image:unsigned

slow
clear

slow 'kubectl get pods -n gatekeeper-system'
kubectl get pods -n gatekeeper-system

slow 'kubectl get verifiers'
kubectl get verifiers

slow 'kubectl get verifier verifier-notary -o json | jq .spec'
kubectl get verifier verifier-notary -o json | jq .spec

slow
clear

slow 'kubectl apply -f https://deislabs.github.io/ratify/library/default/template.yaml'
kubectl apply -f https://deislabs.github.io/ratify/library/default/template.yaml

slow "kubectl get constrainttemplate ratifyverification -o json | jq -r '.spec.targets[0].rego'"
kubectl get constrainttemplate ratifyverification -o json | jq -r '.spec.targets[0].rego'

slow
clear

slow 'kubectl apply -f https://deislabs.github.io/ratify/library/default/samples/constraint.yaml'
kubectl apply -f https://deislabs.github.io/ratify/library/default/samples/constraint.yaml

slow 'kubectl get constraint ratify-constraint -ojson | jq .spec'
kubectl get constraint ratify-constraint -ojson | jq .spec

slow 'kubectl run demo1 --image=wabbitnetworks.azurecr.io/test/notary-image:unsigned'
kubectl run demo1 --image=wabbitnetworks.azurecr.io/test/notary-image:unsigned

slow 'kubectl run demo --image kubeconeu.azurecr.io/demo-app:sha-d0992af7eb825e7ba03fd777016073c3765a1c30'
kubectl run demo --image kubeconeu.azurecr.io/demo-app:sha-d0992af7eb825e7ba03fd777016073c3765a1c30

slow 'kubectl delete pod demo'
kubectl delete pod demo
