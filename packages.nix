{ pkgs, ... }:

{
  home.packages = [
    pkgs.docker-credential-helpers
    pkgs.azure-cli
    pkgs.fd
    pkgs.fluxcd
    pkgs.gcc
    pkgs.gitui
    pkgs.go
    pkgs.kubernetes-helm
    pkgs.kubectl
    pkgs.httpie
    pkgs.jq
    pkgs.nixfmt
    pkgs.nodejs
    pkgs.page
    pkgs.powershell
    pkgs.pulumi
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
  ];
}
