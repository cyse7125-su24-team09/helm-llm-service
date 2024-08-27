# Helm Chart for LLM Service

This Helm chart deploys the `ollama` inference application, which is responsible for hosting a Large Language Model on GPU Nodes.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `llm-service`:

```sh
helm install llm-service . --namespace llm-service --create-namespace
```

This command deploys the `llm-service` application on the Kubernetes cluster in the `llm-service` namespace.

## Uninstalling the Chart

To uninstall/delete the `llm-service` deployment:

```sh
helm uninstall llm-service --namespace llm-service
```

### check values.yaml and change values as desired
