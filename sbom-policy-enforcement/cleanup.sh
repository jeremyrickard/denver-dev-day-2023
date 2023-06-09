#!/bin/zsh
kubectl delete -f package-verifier.yml
kubectl scale --replicas=0 deployment/ratify -n gatekeeper-system
kubectl scale --replicas=1 deployment/ratify -n gatekeeper-system
