{ config, pkgs, ... }:

{
  imports = [
    #../rofi/rofi.nix 
    ../wofi/wofi.nix 
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
