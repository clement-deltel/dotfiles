#!/bin/bash

# Chezmoi
source <(chezmoi completion bash)

# Helm
source <(helm completion bash)

# Kubernetes
source <(kubectl completion bash)

# Poetry
source <(poetry completions bash)
