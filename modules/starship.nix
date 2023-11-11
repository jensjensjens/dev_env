{ config, pkgs, ... }:

{
    programs = {
        starship = {
            enable = true;
            enableZshIntegration = true;
        };
    };
    xdg = {
        configFile = {
            starship = {
                source = ./. + "/starship.toml";
                target = "starship.toml";
            };
        };
    };
}
