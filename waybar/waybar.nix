{ config, pkgs, ... }:

{
  xdg = {
    configFile = {
      waybar = {
        source = ./. + "/config";
        target = "waybar";
      };
    };
  };
}
