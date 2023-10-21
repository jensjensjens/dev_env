{ config, pkgs, ... }:

{
  xdg = {
    configFile = {
      wofi = {
        source = ./. + "/config";
        target = "wofi";
      };
    };
  };
}
