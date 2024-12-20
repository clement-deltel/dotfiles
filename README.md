# dotfiles
Personal dotfiles managed with chezmoi.

## Pre-requisites

To fully enjoy the features offered by those dotfiles, you'll need to install the required packages listed down below:

- chezmoi
- docker
- k9s
- kubernetes-cli
- net-tools
- pyenv
- python

## Install chezmoi

Set up a new machine with two commands:
```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init --apply $GITHUB_USERNAME
```

## Install Zsh

Instead of bash it is possible to use the Zsh shell. Here are the steps to set it up:

1. Update package list and upgrade packages:
```bash
sudo apt update -y && sudo apt upgrade -y
```

2. Install dependencies:
```bash
sudo apt install -y git wget
```

3. Install Zsh and oh-my-zsh:
```bash
sudo apt install zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

4. Here is my favorite theme: Powerlevel10k
5. Here is a list of handy plugins:
   - zsh-syntax-highlighting
   - zsh-autosuggestions
