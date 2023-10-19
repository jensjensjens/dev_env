{ pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  home.packages = [
    pkgs.docker-credential-helpers
    pkgs.fd
    pkgs.gcc
    pkgs.httpie
    pkgs.jq
    pkgs.nixfmt
    pkgs.nodejs
    pkgs.page
    pkgs.powershell
    pkgs.python311
    pkgs.ranger
    pkgs.ripgrep
    pkgs.slides
    pkgs.sops
    pkgs.statix
    pkgs.tree-sitter
    pkgs.unzip
    pkgs.viddy
    pkgs.wget
    pkgs.xclip
    pkgs.xplr
    pkgs.yq
    pkgs.zellij
    unstable.go_1_21
    unstable.azure-cli
    unstable.fluxcd
    unstable.gitui
    unstable.kubectl
    unstable.kubernetes-helm
    unstable.pulumi
  ];
}
