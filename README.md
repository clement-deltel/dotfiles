# dotfiles

Personal dotfiles managed with [chezmoi][1].

## Linux

### Ubuntu

1. Install chezmoi:
```bash
sudo apt update -y
sudo apt install -y curl git
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init --apply clement-deltel
```
2. After pulling and configuring the dotfiles, chezmoi run a script installing ansible, and then running playbooks.
3. Ansible playbooks automatically install and configure the tools listed below:
    - Package Managers
      - apt
        - [fzf][2]
        - [htop][3]
        - pwgen
        - [vim][4]
      - [homebrew][5]
    - Shell
      - zsh
      - [zoxide][6]
    - Languages
      - Go
      - Python
        - [pipx][7]
        - [poetry][8]
        - [pyenv][9]
    - Orchestration
      - Docker
      - Kubernetes
        - [helm][10]
        - [kubectl][11]
        - [k9s][12]
        - [stern][13]
    - Infrastructure as Code
      - [Pulumi][14]
      - [Terraform][15]
    - Cloud
      - AWS CLI

If you want to test this setup, you need to have Docker installed and then you can run the commands below:
```bash
docker build --build-arg GITHUB_USERNAME=clement-deltel --file docker/linux/Dockerfile --tag dotfiles .
docker run --interactive --name dotfiles --tty --rm dotfiles
```
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

[1]:https://www.chezmoi.io
[2]:https://github.com/junegunn/fzf
[3]:https://github.com/htop-dev/htop
[4]:https://github.com/vim/vim
[5]:https://github.com/Homebrew/brew
[6]:https://github.com/ajeetdsouza/zoxide
[7]:https://github.com/pypa/pipx
[8]:https://github.com/python-poetry/poetry
[9]:https://github.com/pyenv/pyenv
[10]:https://github.com/helm/helm
[11]:https://github.com/kubernetes/kubectl
[12]:https://github.com/derailed/k9s
[13]:https://github.com/stern/stern
[14]:https://github.com/pulumi/pulumi
[15]:https://github.com/hashicorp/terraform
