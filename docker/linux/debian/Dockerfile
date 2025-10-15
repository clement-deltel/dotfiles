# Instructions creating a new layer: ADD, COPY, RUN

# https://hub.docker.com/_/ubuntu
ARG IMAGE="ubuntu:22.04"

# ---------------------------------------------------------------------------- #
#               ------- Base ------
# ---------------------------------------------------------------------------- #
FROM ${IMAGE} AS base

# Not persisted into the built image
ARG DEBIAN_FRONTEND=noninteractive
ARG MACHINE=pro
ARG IMAGE=ubuntu:22.04
ARG ID=10001
ARG USER=linux
ARG TIMEZONE=America/New_York

ARG BW_SERVER
ARG BW_CLIENTID
ARG BW_CLIENTSECRET
ARG BW_PASSWORD

# https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="dotfiles-${IMAGE}"
LABEL org.opencontainers.image.description="dotfiles-${IMAGE}"
LABEL org.opencontainers.image.authors="Clement Deltel <38040315+clement-deltel@users.noreply.github.com>"

# Persisted into the built image
ENV TZ=${TIMEZONE}

# Install dependencies
# hadolint ignore=DL3008
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y curl sudo tzdata && \
    apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt /var/lib/cache /var/lib/log

# Create group, user, and grant sudo permissions without password
RUN groupadd --gid ${ID} ${USER} && \
    useradd --create-home --gid ${ID} --home /home/${USER} --shell /bin/bash --uid ${ID} ${USER} && \
    usermod -aG sudo ${USER} && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
# Remove setuid and setgid permissions to prevent privilege escalation
# https://github.com/goodwithtech/dockle/blob/master/CHECKPOINT.md#cis-di-0008
    chmod u-s /usr/bin/su /usr/bin/chsh /usr/bin/mount /usr/bin/chfn \
              /usr/bin/umount /usr/bin/newgrp /usr/bin/passwd /usr/bin/gpasswd && \
    chmod g-s /usr/bin/expiry /usr/sbin/unix_chkpwd /usr/bin/chage

WORKDIR /home/${USER}

# ---------------------------------------------------------------------------- #
#               ------- Development Dotfiles ------
# ---------------------------------------------------------------------------- #
FROM base AS development

ENV DISABLE_INIT=true

# Copy and run installation script
COPY --chown=${USER} ./install.sh ./install.sh
USER ${USER}
RUN chmod +x ./install.sh && ./install.sh

ENTRYPOINT ["/bin/bash"]

# ---------------------------------------------------------------------------- #
#               ------- Production Dotfiles ------
# ---------------------------------------------------------------------------- #
FROM base AS production

ARG GITHUB_USERNAME=clement-deltel
ENV GITHUB_USERNAME=${GITHUB_USERNAME}

# Copy and run installation script
COPY --chown=${USER} ./install.sh ./install.sh
USER ${USER}
RUN chmod +x ./install.sh && ./install.sh

ENTRYPOINT ["/bin/zsh"]
