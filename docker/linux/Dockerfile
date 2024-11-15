# Use official Ubuntu image as a parent image
FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Clement Deltel <38040315+clement-deltel@users.noreply.github.com>"
LABEL org.opencontainers.image.title="dotfiles-ubuntu"
LABEL org.opencontainers.image.description=""

# Not persisted into the built image
ARG ID="1000"
ARG USER="ubuntu"
ARG BW_SERVER
ARG BW_CLIENTID
ARG BW_CLIENTSECRET
ARG BW_PASSWORD
ARG GITHUB_USERNAME
ARG TZ

# Persisted into the built image
ENV DEBIAN_FRONTEND=noninteractive
ENV BW_SERVER=${BW_SERVER}
ENV BW_CLIENTID=${BW_CLIENTID}
ENV BW_CLIENTSECRET=${BW_CLIENTSECRET}
ENV BW_PASSWORD=${BW_PASSWORD}
ENV GITHUB_USERNAME=${GITHUB_USERNAME}
ENV TZ=${TZ}

# Install pre-requisites packages, including Bitwarden CLI
RUN apt update -y && apt install -y curl git jq libsecret-1-0 sudo tzdata unzip &&\
    export BW_VERSION=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/bitwarden/clients/releases | jq  -r 'sort_by(.published_at) | reverse | .[].name | select( index("CLI") )' | sed "s:.*CLI v::" | head -n 1) &&\
    curl -LO "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip" &&\
    unzip -d /usr/local/bin bw-linux-*.zip &&\
    chmod +x /usr/local/bin/bw &&\
    rm -f bw-linux-*.zip

# Create group, user, and grant sudo permissions without password
RUN groupadd --gid ${ID} ${USER} && \
    useradd --create-home --gid ${ID} --home /home/${USER} --shell /bin/bash --uid ${ID} ${USER} &&\
    adduser ${USER} sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /home/${USER}

COPY --chown=${USER} docker/linux/install.sh ./install.sh
RUN chmod +x ./install.sh
USER ${USER}

# Configure Bitwarden CLI and run install
RUN bw config server ${BW_SERVER} &&\
    bw login --apikey &&\
    export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw) &&\
    mkdir -p ~/.config/chezmoi &&\
    bw get notes chezmoi > ~/.config/chezmoi/chezmoi.toml &&\
    ./install.sh

ENTRYPOINT ["/bin/bash"]
# ENTRYPOINT ["./install.sh"]
