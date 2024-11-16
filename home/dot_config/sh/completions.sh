#!/bin/bash

# Configuration Management - Chezmoi
source <(chezmoi completion bash)

# Infrastructure as code
source <(terraform -install-autocomplete)

# Language - Python
source <(poetry completions bash)

# Orchestration
source <(docker completion bash)
source <(helm completion bash)
source <(kubectl completion bash)

# Version Control
source /usr/share/bash-completion/completions/git
