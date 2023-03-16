#!/bin/bash
# .bashrc
# Author: Clement Deltel <clement.deltel@proton.me>
# Source: https://github.com/clement-deltel/dotfiles/.bashrc

#==============================================================================#
#               ------- Colors ------                                          #
#==============================================================================#
RED='\e[1;31m'
NC='\e[0m'

#==============================================================================#
#               ------- Configuration --------                                 #
#==============================================================================#

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Shell optional behavior
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize # check the window size after each command
shopt -s cmdhist
shopt -s histappend # append to the history file, don't overwrite it
shopt -s histreedit
shopt -s progcomp
shopt -s sourcepath

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=999999
export HISTFILESIZE=999999

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoredups:ignorespace

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Prompt
PS1='${debian_chroot:+($debian_chroot)}\u@\h:$(pwd) /> '

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

set -o ignoreeof    # Shell doesnt quit upon reading the end of file.
#set -o noclobber   # Prevents overwriting existing regular files
set -o notify       # Alerts the user upon background job termination
#set -o xtrace      # Prints out command arguments during execution
set -o vi           # Set vi mode for shell

#==============================================================================#
#               ------- Functions ------                                       #
#==============================================================================#

# Print only column x of output
function col {
  awk -v col="$1" '{print $col}'
}

# Add extension $1 to all files without any extension in the current directory
function add-ext-fn { find . -type f -not -name "*.*" -exec mv "{}" "{}"."$1" \;; }

# Create $2 copies of file $1
function cp-n-fn { EXT="${1##*.}"; FILENAME="${1%.*}"; for i in $(seq 1 "$2"); do cp "$1" "${FILENAME}${i}.${EXT}"; done; }

# Execute $@ command in all the subdirectories
function exec-subdir-fn { find . -maxdepth 1 -mindepth 1 -type d -execdir echo {} \; -execdir $@ {} \; -execdir echo \;; }

# Make directory $1 and then cd inside
function mkdir-cd-fn { mkdir "$1"; cd "$1" || return; }


# Host Info

# IP adresses
function my-ip(){
    MY_IP=$(/sbin/ifconfig enp0s3 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
}

# Full summary
function ii() {
    echo -e "\nYou are logged on ${RED}$(hostname)"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my-ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo "${MY_IP:-"Not connected"}"
    echo
}

#==============================================================================#
#               ------- Functions - Docker ------                              #
#==============================================================================#
function docker-compose-fn { docker compose "$@"; }
function docker-compose-run-fn { docker compose run "$@"; }
function docker-exec-fn { docker exec -it "$1" "${2:-bash}"; }
function docker-image-rm-fn { docker image rm "$1"; }
function docker-inspect-fn { docker inspect "$1"; }
function docker-ip-fn {
  echo "IP addresses of all named running containers"

  for DOC in $(dnames-fn)
  do
       IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' "$DOC")
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
function docker-pull-fn { docker pull "$1"; }
function docker-rm-exited-fn { docker rm "$(docker ps --all -q -f status=exited)"; }
function docker-rm-dangling-images-fn {
       IMGS=$(docker images -q -f dangling=true)
       [ -n "$IMGS" ] && docker rmi "$IMGS" || echo "no dangling images."
}
function docker-rm-dangling-volumes-fn {
       VOLS=$(docker volume ls -q -f dangling=true)
       [ -n "$VOLS" ] && docker volume rm "$VOLS" || echo "no dangling volumes."
}
function docker-run-fn { docker run -it "$1" "$2"; }
function docker-stop-rm-fn { docker stop "$1"; docker rm "$1"; }

#==============================================================================#
#               ------- Functions - Aliases --------                           #
#==============================================================================#
alias add-ext=add-ext-fn
alias cp-n=cp-n-fn
alias exec-sub=exec-subdir-fn
alias mkcd=mkdir-cd-fn

alias dc=docker-compose-fn
alias dcru=docker-compose-run-fn
alias dex=docker-exec-fn
alias di=docker-inspect-fn
alias dip=docker-ip-fn
alias dirm=docker-image-rm-fn
alias dl=docker-logs-fn
alias dnames=docker-names-fn
alias dpu=docker-pull-fn
alias drmc=docker-rm-exited-fn
alias drmid=docker-rm-dangling-images-fn
alias drmvd=docker-rm-dangling-volumes-fn
alias drun=docker-run-fn
alias dsr=docker-stop-rm-fn
#==============================================================================#
#               ------- Aliases --------                                       #
#==============================================================================#

# Global
alias c='clear'
alias cls='clear'
alias d='date'
alias k='kill'
alias q='exit'
alias t='time'

# bashrc
alias vib='vi ~/.bashrc'
alias srb='source ~/.bashrc'
alias cab='cat ~/.bashrc'

# cd
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'

# cp
alias cp='cp -i'

# du
alias du-sort='du -sh * | sort -h'

# env
alias env='clear && env | sort'

# grep
alias grep='grep --color=auto'

# history
alias h='clear && history | tail -50'

# ls
alias ll='ls -l --color=auto'
alias la='ls -Al --color=auto'
alias lah='ls -Ahl --color=auto'
alias lk='ls -lSr'          # sort by size
alias lr='ls -lR'           # recursive ls
alias ltr='ls -ltr'         # sort by date
alias lx='ls -lXB'          # sort by extension

# mv
alias mv='mv -i'

# rm
alias rm='rm -i'

# su
alias root='su -'

# tree
alias tree='tree -Csu'		# nice alternative to 'ls'

# vim
alias vimo='vim -o '

# Docker
alias dim='docker images'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpsf='docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"'
alias dsp='docker system prune --all'

# Docker Compose file
alias catdc='cat compose.yaml'
alias vidc='vim compose.yaml'

# Docker Compose CLI
alias dcd='docker compose down -v'
alias dcu='docker compose up -d'
alias dcub='docker compose up -d --build'
alias dcr='docker compose restart'
alias dcsta='docker compose start'
alias dcsto='docker compose stop'

#==============================================================================#
#               ------- Aliases - Typos --------                               #
#==============================================================================#
alias :q='exit'
