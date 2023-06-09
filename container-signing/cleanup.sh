#!/bin/zsh
kubectl delete -f https://deislabs.github.io/ratify/library/default/template.yaml
kubectl delete pod demo
