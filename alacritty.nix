{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Terminal";

        padding = { y = 5; };
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        normal.family = "MesloLgm Nerd Font Mono";
        size = 10.0;
      };

      shell = { program = "${pkgs.zsh}/bin/zsh"; };
    };
  };
}
