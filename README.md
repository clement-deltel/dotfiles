# dotfiles

Personal dotfiles managed with [chezmoi][1].

## Linux

### Ubuntu

1. Install dependencies, Bitwarden CLI and finally chezmoi:
```bash
# Dependencies
sudo apt update -y
sudo apt install -y curl git jq libsecret-1-0 unzip
# Bitwarden CLI
export BW_VERSION=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/bitwarden/clients/releases | jq  -r 'sort_by(.published_at) | reverse | .[].name | select( index("CLI") )' | sed "s:.*CLI v::" | head -n 1)
curl -L --remote-name "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip"
sudo unzip -d /usr/local/bin bw-linux-*.zip
sudo chmod +x /usr/local/bin/bw
rm -f bw-linux-*.zip
# chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"
```

2. Export required environment variables:
```bash
# Fill the blanks with your configuration
export BW_SERVER="https://bw.domain.com"
export BW_CLIENTID=""
export BW_CLIENTSECRET=""
export BW_PASSWORD=''
export GITHUB_USERNAME=clement-deltel
```

3. Get chezmoi configuration file from Bitwarden and initialize the dotfiles
```bash
bw config server ${BW_SERVER}
bw login --apikey
export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
bw get notes chezmoi > ~/.config/chezmoi/chezmoi.toml
bw lock
```

4. Initialize the dotfiles:
```bash
export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
chezmoi init --apply ${GITHUB_USERNAME}
bw lock
```

5. After pulling and configuring the dotfiles, chezmoi run a script installing ansible, and then running playbooks.
6. Ansible playbooks automatically install and configure the tools listed below:
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
export BW_SERVER="https://bw.domain.com"
export BW_CLIENTID=""
export BW_CLIENTSECRET=""
export BW_PASSWORD=''
export GITHUB_USERNAME=clement-deltel

# Docker build and then run
docker build --build-arg BW_SERVER --build-arg BW_CLIENTID --build-arg BW_CLIENTSECRET --build-arg BW_PASSWORD --build-arg GITHUB_USERNAME --file docker/linux/Dockerfile --tag dotfiles .
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
