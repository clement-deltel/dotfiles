#!/bin/bash

# Configuration Management - Chezmoi
eval "$(chezmoi completion bash)"

# Infrastructure as Code
eval "$(terraform -install-autocomplete)"

# Language - Python
eval "$(poetry completions bash)"

# Orchestration
eval "$(docker completion bash)"
eval "$(helm completion bash)"
eval "$(kubectl completion bash)"

# Shell
eval "$(fzf --bash)"

# Version Control
source /usr/share/bash-completion/completions/git
eval "$(gitleaks completion bash)"
