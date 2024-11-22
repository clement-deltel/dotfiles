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
ENV GITHUB_USERNAME=${GITHUB_USERNAME}
ENV TZ=${TZ}

# Create group, user, and grant sudo permissions without password
RUN groupadd --gid ${ID} ${USER} && \
    useradd --create-home --gid ${ID} --home /home/${USER} --shell /bin/bash --uid ${ID} ${USER} &&\
    adduser ${USER} sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /home/${USER}

COPY --chown=${USER} ./install.sh ./install.sh
USER ${USER}

# Install dependencies and run installation script
RUN sudo apt update -y && sudo apt install -y curl tzdata &&\
    chmod +x ./install.sh && ./install.sh

ENTRYPOINT ["/bin/zsh"]
