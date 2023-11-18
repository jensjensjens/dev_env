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
            PULUMI_SKIP_UPDATE_CHECK = "true";
        };

        shellAliases = {
            watch = "${pkgs.viddy}/bin/viddy";
        };
    };

    programs.home-manager.enable = true;
}
