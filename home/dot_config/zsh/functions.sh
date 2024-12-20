#!/bin/bash

#==============================================================================#
#               ------- General ------                                         #
#==============================================================================#

# Print only column x of output
function col { awk -v col="$1" '{print $col}'; }

# Add extension $1 to all files without any extension in the current directory
function add-ext { find . -type f -not -name "*.*" -exec mv "{}" "{}"."$1" \;; }

# Create $2 copies of file $1
function cp-n { EXT="${1##*.}"; FILENAME="${1%.*}"; for i in $(seq 1 "$2"); do cp "$1" "${FILENAME}${i}.${EXT}"; done; }

# Execute $@ command in all the subdirectories
function exec-sub { find . -maxdepth 1 -mindepth 1 -type d -execdir echo {} \; -execdir $@ {} \; -execdir echo \;; }

# Make directory $1 and then cd inside
function mkcd { mkdir "$1"; cd "$1" || return; }

# Base64 decoding
function dec { echo "$1" | base64 --decode; }

# Host Info

# IP adresses
function my-ip (){
  MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 }' | sed -e s/addr://)
}

# Full summary
function ii (){
  echo -e "\nYou are logged on ${RED}$(hostname)"
  echo -e "\nAdditionnal information:$NC" ; uname -a
  echo -e "\n${RED}Users logged on:$NC" ; w -h
  echo -e "\n${RED}Current date:$NC" ; date
  echo -e "\n${RED}Machine stats:$NC" ; uptime
  echo -e "\n${RED}Memory stats:$NC" ; free
  my-ip 2>&- ;
  echo -e "\n${RED}Local IP Address:$NC" ; echo "${MY_IP:-"Not connected"}"
  echo
}

# Online cheatsheet
function cheatsheet { curl cheat.sh/"$1"; }

#==============================================================================#
#               ------- Chezmoi ------                                         #
#==============================================================================#
function chezmoi-add-fn { chezmoi add "$1"; }
function chezmoi-add-template-fn { chezmoi add --template "$1"; }
function chezmoi-edit-fn { chezmoi edit "$1"; }
function chezmoi-fn { chezmoi "$@"; }

#==============================================================================#
#               ------- Docker ------                                          #
#==============================================================================#
function docker-exec-fn { docker exec -it "$1" "${2:-bash}"; }
function docker-fn { docker "$@"; }
function docker-image-rm-fn { docker image rm "$1"; }
function docker-image-rm-dangling-fn {
    IMGS=$(docker images --filter "dangling=true" -q --no-trunc)
    [[ -n ${IMGS} ]] && docker rmi ${IMGS} || echo "no dangling images."
}
function docker-inspect-fn { docker inspect "$1"; }
function docker-ip-fn {
  echo "IP addresses of all named running containers"
  for DOC in $(docker-names-fn)
  do
    IP=$(docker inspect --format='{{ "{{" }}range .NetworkSettings.Networks{{ "}}" }}{{ "{{" }}.IPAddress{{ "}}" }} {{ "{{" }}end{{ "}}" }}' "$DOC")
    OUT+=$DOC'\t'$IP'\n'
  done
  echo -e "$OUT" | column -t
  unset OUT
}
function docker-logs-fn { docker logs -f "$1"; }
function docker-names-fn {
	for ID in $(docker ps | awk '{print $1}' | grep -v 'CONTAINER')
	do
    docker inspect "$ID" | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
	done
}
function docker-network-rm-fn { docker network rm "$1"; }
function docker-pull-fn { docker pull "$1"; }
function docker-rm-exited-fn { docker rm "$(docker ps --all -q -f status=exited)"; }
function docker-run-fn { docker run -it "$1" "$2"; }
function docker-stop-rm-fn { docker stop "$1"; docker rm "$1"; }
function docker-volume-rm-fn { docker volume rm "$1"; }
function docker-volume-rm-dangling-fn {
    VOLS=$(docker volume ls --filter "dangling=true" -q)
    [[ -n ${VOLS} ]] && docker volume rm ${VOLS} || echo "no dangling volumes."
}

#==============================================================================#
#               ------- Docker Compose ------                                  #
#==============================================================================#
function docker-compose-fn { docker compose "$@"; }
function docker-compose-run-fn { docker compose run "$@"; }

#==============================================================================#
#               ------- Kubernetes ------                                      #
#==============================================================================#

# When using aliases, print kubectl command and then execute it
function kctl() { echo "+ kubectl $@" && command kubectl $@ }

function kctl-decode-secret-fn { kctl get secret "$1" -o=jsonpath='{.data}' | base64 --decode; echo; }
function kctl-delete-pod-fn { kctl delete pod "$1"; }
function kctl-describe-deployment-fn { kctl describe deployment "$1"; }
function kctl-describe-pod-fn { kctl describe pod "$1"; }
function kctl-edit-deployment-fn { kctl edit deployment "$1"; }
function kctl-edit-secret-fn { kctl edit secret "$1"; }
function kctl-get-secret-json-fn { kctl get secret "$1" -o jsonpath='{.data}'; }
function kctl-logs-fn { kctl logs -f "$1"; }
function kctl-port-forward-fn { kctl port-forward service/"$1" "$2":"$2"; }
function kctl-rollout-restart-deployment-fn { kctl rollout restart deployment "$2"; }

#==============================================================================#
#               ------- Python ------                                          #
#==============================================================================#
function venv-activate { pyenv activate "$1"; }
function venv-create-fn { pyenv virtualenv "$1" "$2"; }
function venv-delete-fn { pyenv virtualenv-delete "$1"; }
function venv-set-local-fn { pyenv local "$1"; }

#==============================================================================#
#               ------- Terraform ------                                       #
#==============================================================================#
function terraform-fn { terraform "$@"; }
function terraform-state-fn { terraform state "$@"; }
