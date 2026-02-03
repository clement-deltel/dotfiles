#!/bin/bash

# Configuration Management - Chezmoi
eval "$(chezmoi completion bash)"

# Cloud
complete -C '/usr/local/bin/aws_completer' aws

# Infrastructure as Code (IaC)
eval "$(pulumi gen-completion bash)"
eval "$(terraform -install-autocomplete)"

# Language - Python
eval "$(register-python-argcomplete cz)"
eval "$(register-python-argcomplete pipx)"
eval "$(poetry completions bash)"
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"
source ${HOME}/.pyenv/completions/pyenv.bash

# Orchestration
eval "$(docker completion bash)"
eval "$(grype completion bash)"
eval "$(helm completion bash)"
eval "$(helmfile completion bash)"
eval "$(kubectl completion bash)"
eval "$(stern --completion bash)"
eval "$(trivy completion bash)"

# Tools
eval "$(fzf --bash)"
eval "$(gonzo completion bash)"
eval "$(just --completions bash)"
eval "$(procs --gen-completion-out bash)"
# eval "$(rg --generate complete-bash)" # TODO: not working
eval "$(yq shell-completion bash)"

# Version Control System (VCS)
eval "$(gitleaks completion bash)"
eval "$(_GITLINT_COMPLETE=bash_source gitlint)"
eval "$(COMPLETE=bash prek)"
source /usr/share/bash-completion/completions/git
