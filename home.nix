{ config, pkgs, lib, ... }:

{
    fonts.fontconfig.enable = true;

    home = {
        stateVersion = "23.05";
        username = "jenss";
        homeDirectory = "/home/jenss";

        sessionVariables = {
            DOCKER_BUILDKIT = 1;
            MANPAGER = "page -t man";
            PAGER = "less";
        };

        sessionPath = [
          "$HOME/.local/bin"
        ];
    };

    programs.home-manager.enable = true;
}
