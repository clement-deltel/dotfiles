#!/bin/bash

#==============================================================================#
#               ------- Chezmoi ------                                         #
#==============================================================================#
{{- if eq .machine "work" }}
source <(chezmoi completion zsh)
{{- else }}
# source <(chezmoi completion zsh)
{{- end }}

#==============================================================================#
#               ------- Helm ------                                            #
#==============================================================================#
{{- if eq .machine "work" }}
source <(helm completion zsh)
{{- else }}
# source <(helm completion zsh)
{{- end }}

#==============================================================================#
#               ------- Kubernetes ------                                      #
#==============================================================================#
{{- if eq .machine "work" }}
source <(kubectl completion zsh)
{{- else }}
# source <(kubectl completion zsh)
{{- end }}

#==============================================================================#
#               ------- Poetry ------                                          #
#==============================================================================#
# {{- if eq .machine "work" }}
# source <(poetry completions zsh)
# {{- else }}
# # source <(poetry completions zsh)
# {{- end }}
