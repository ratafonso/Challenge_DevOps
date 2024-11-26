# Azure Agent Container in Docker/Kubernetes

Build Image

```docker build . -t 5487121354787.dkr.ecr.eu-central-1.amazonaws.com/azure-agent:latest```

Start the container:

docker run -e AWS_POOL=<Pool Name> -e AZP_URL=<Azure DevOps instance> -e AZP_TOKEN=<PAT token> -e maven=true -e AZP_AGENT_NAME=mydockeragent 5487121354787.dkr.ecr.eu-central-1.amazonaws.com/azure-agent:latest

Fresh container each time:

docker run -e AWS_POOL=<Pool Name> -e AZP_URL=<Azure DevOps instance> -e AZP_TOKEN=<PAT token> -e maven=true -e AZP_AGENT_NAME=mydockeragent 5487121354787.dkr.ecr.eu-central-1.amazonaws.com/azure-agent:latest --once

Create secret to seal:

echo -n "<PAT TOKEN>" | kubectl create secret generic azure-agent-pat --dry-run=client --from-file=pat=/dev/stdin --namespace=azureagent -o json > pat-token-secret.json
kubeseal < pat-token-secret.json > pat-token-sealed-secret.json
rm pat-token-secret.json
kubectl create -f pat-token-sealed-secret.json