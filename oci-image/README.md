docker buildx build --output="type=oci,name=kubeconey.azurecr.io/test/cowsay,dest=cowsay.tar" --platform linux/amd64,linux/arm64 --tag kubeconeu.azurecr.io/test/cowsay .


