crane manifest kubeconeu.azurecr.io/test/cowsay:latest

crane manifest kubeconeu.azurecr.io/test/cowsay@sha256:ca79ad482b293a0c34ba1044594356a827a1a74374fd1d463e1087935a542e67

crane blob kubeconeu.azurecr.io/test/cowsay@sha256:f2131a27ab9c8a2c55e5a33ce861393bf5934a64d16b508f4532a8e749937df7 > layer.tgz

tar tvf layer.tgz