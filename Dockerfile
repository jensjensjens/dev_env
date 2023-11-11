FROM ubuntu:latest AS core

SHELL ["/bin/bash", "-c", "-o", "pipefail"]

ENV TZ=Europe/Stockholm
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd --create-home --shell /bin/bash jenss && \
    usermod -aG sudo jenss && \
    mkdir -m 0755 /nix && \
    chown jenss /nix

RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nix && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

USER jenss
ENV USER=jenss
ENV NIX_PATH=${NIX_PATH:+$NIX_PATH:}/home/jenss/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
ENV PATH="${PATH}:/home/jenss/.nix-profile/bin"

WORKDIR /home/jenss


RUN sh <(curl -L https://nixos.org/nix/install) --no-daemon

RUN nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && \
    nix-channel --update && \
    nix-shell '<home-manager>' -A install

COPY . .config/home-manager

RUN home-manager switch

ENTRYPOINT [ "zsh" ]
