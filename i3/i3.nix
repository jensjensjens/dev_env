{ config, pkgs, ... }:

{
  xdg = {
    configFile = {
      i3 = {
        source = ./. + "/i3";
      };

      polybar = {
        source = ./. + "/polybar";
      };
      
      picom = {
        source = ./. + "/picom";
      };
    };

    dataFile = {
      rofi-themes = {
        source = ./. + "/rofi-themes";
        recursive = true;
        onChange = ''
          cd ${config.xdg.dataHome}/rofi-themes
          ./setup.sh
        '';
      };
    };
  };

  xsession = {
    windowManager = {
      i3 = {
        config = {
          menu = "${pkgs.rofi}/bin/rofi";
        };
      };
    };
  };

  programs = {
    rofi = {
      enable = true;
      theme = "gruvbox-dark-hard";
      terminal = "${pkgs.alacritty}/bin/alacritty";
    };
  };
}
