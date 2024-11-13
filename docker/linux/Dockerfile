# Use official Ubuntu image as a parent image
FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Clement Deltel <38040315+clement-deltel@users.noreply.github.com>"
LABEL org.opencontainers.image.title="dotfiles-ubuntu"
LABEL org.opencontainers.image.description=""

# Not persisted into the built image
ARG ID="1000"
ARG USER="ubuntu"
ARG GITHUB_USERNAME
ARG TZ

# Persisted into the built image
ENV DEBIAN_FRONTEND=noninteractive
ENV GITHUB_USERNAME=${GITHUB_USERNAME}
ENV TZ=${TZ}

# Install pre-requisites packages
RUN apt update && apt install -y curl git tzdata sudo

# Create group, user, and grant sudo permissions without password
RUN groupadd --gid ${ID} ${USER} && \
    useradd --create-home --gid ${ID} --home /home/${USER} --shell /bin/bash --uid ${ID} ${USER} &&\
    adduser ${USER} sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /home/${USER}

COPY --chown=${USER} chezmoi.toml.example ./.config/chezmoi/chezmoi.toml
COPY --chown=${USER} docker/linux/install.sh ./install.sh
RUN chmod +x ./install.sh

USER ${USER}

RUN ./install.sh
ENTRYPOINT ["/bin/bash"]

# ENTRYPOINT ["./install.sh"]
