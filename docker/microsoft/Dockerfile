FROM mcr.microsoft.com/windows/servercore:ltsc2022

LABEL org.opencontainers.image.authors="Clement Deltel <38040315+clement-deltel@users.noreply.github.com>"
LABEL org.opencontainers.image.title="dotfiles-windows"
LABEL org.opencontainers.image.description=""

# Not persisted into the built image
ARG GITHUB_USERNAME

# Persisted into the built image
ENV GithubUsername=${GITHUB_USERNAME}

# Set the default shell
SHELL ["powershell", "-Command"]

# Install pre-requisites packages
RUN winget install --exact --id Git.Git

COPY chezmoi.toml.example ./.config/chezmoi/chezmoi.toml
COPY docker/microsoft/install.ps1 ./install.ps1

RUN ./install.ps1
ENTRYPOINT ["powershell"]
