# dotfiles

Personal dotfiles managed with [chezmoi][1].

## Linux

### Ubuntu

1. Export required environment variables:
```bash
# Fill the blanks with your configuration
export BW_CLIENTID=
export BWCLIENTSECRET=
export BW_SERVER="https://bw.domain.com"
export GITHUB_USERNAME=clement-deltel
```
2. Install dependencies, Bitwarden CLI and finally chezmoi:
```bash
# Dependencies
sudo apt update -y
sudo apt install -y curl git jq libsecret-1-0 unzip
# Bitwarden CLI
export VERSION=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/bitwarden/clients/releases | jq  -r 'sort_by(.published_at) | reverse | .[].name | select( index("CLI") )' | sed "s:.*CLI v::" | head -n 1)
curl -LO "https://github.com/bitwarden/clients/releases/download/cli-v{$VERSION}/bw-linux-{$VERSION}.zip"
unzip *.zip
chmod +x ./bw
bw config server ${BW_SERVER}
bw login --apikey
# chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init --apply ${GITHUB_USERNAME}
```
3. After pulling and configuring the dotfiles, chezmoi run a script installing ansible, and then running playbooks.
4. Ansible playbooks automatically install and configure the tools listed below:
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
# Set build args
export BW_CLIENTID=
export BWCLIENTSECRET=
export BW_SERVER="https://bw.domain.com"
export GITHUB_USERNAME=clement-deltel

# Docker build and then run
docker build --build-arg BW_CLIENTID --build-arg BW_CLIENTSECRET --build-arg BW_SERVER --build-arg GITHUB_USERNAME --file docker/linux/Dockerfile --tag dotfiles .
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
