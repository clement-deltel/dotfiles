# Not persisted into the built image
ARG MACHINE="work"
ARG IMAGE="ubuntu:22.04"
ARG ID="1000"
ARG USER="linux"
ARG TIMEZONE="America/New_York"

# Use image passed as argument as a parent image
FROM ${IMAGE}

LABEL org.opencontainers.image.authors="Clement Deltel <38040315+clement-deltel@users.noreply.github.com>"
LABEL org.opencontainers.image.title="dotfiles-${IMAGE}"
LABEL org.opencontainers.image.description="dotfiles-${IMAGE}"

# Not persisted into the built image
ARG BW_SERVER
ARG BW_CLIENTID
ARG BW_CLIENTSECRET
ARG BW_PASSWORD
ARG GITHUB_USERNAME

# Persisted into the built image
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=${TIMEZONE}
ENV GITHUB_USERNAME=${GITHUB_USERNAME}

# Install dependencies
RUN apt update -y && apt install -y curl sudo tzdata

# Create group, user, and grant sudo permissions without password
RUN groupadd --gid ${ID} ${USER} && \
    useradd --create-home --gid ${ID} --home /home/${USER} --shell /bin/bash --uid ${ID} ${USER} &&\
    adduser ${USER} sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /home/${USER}

COPY --chown=${USER} ./install.sh ./install.sh
USER ${USER}

# Run installation script
RUN chmod +x ./install.sh && ./install.sh

ENTRYPOINT ["/bin/zsh"]
