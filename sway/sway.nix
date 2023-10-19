{ config, pkgs, ... }:

{
  imports = [
    ../rofi/rofi.nix 
    ../waybar/waybar.nix 
  ];

  xdg = {
    configFile = {
      sway = {
        source = ./. + "/config";
        target = "sway";
      };
    };
  };
}
