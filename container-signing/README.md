# ratify-demo

# Setup Gatekeeper

helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts

helm install gatekeeper/gatekeeper  \
    --name-template=gatekeeper \
    --namespace gatekeeper-system --create-namespace \
    --set enableExternalData=true \
    --set validatingWebhookTimeoutSeconds=5 \
    --set mutatingWebhookTimeoutSeconds=2

# Setup Ratify to enable dynamic plugins and verify things!

export CERTIFICATE_PATH=./jeremyrickard-github-io.pem
export DYNAMIC_PLUGINS=true
helm install ratify ratify/ratify \
    --atomic --namespace gatekeeper-system \
    --set cosign.enabled=false \
    --set-file notaryCert=${CERTIFICATE_PATH} \
    --set image.tag=v1.0.0-rc.3 \
     --set featureFlags.RATIFY_DYNAMIC_PLUGINS=${DYNAMIC_PLUGINS}

# Run the dmeo

Run the demo by running the `ratify-verify.sh`script. It uses a function called `slow` so it will show the commands that are being used.

# Clean Up

Run the cleanup.sh script!

