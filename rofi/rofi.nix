{ config, pkgs, ... }:

{
  xdg = {
    configFile = {
      rofi = {
        source = ./. + "/config";
        target = "rofi";
      };
    };
  };
}
