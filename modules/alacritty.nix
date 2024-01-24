{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Terminal";

        padding = {
          y = 10;
          x = 5;
        };
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        normal.family = "MesloLgs NF";
        size = 13.0;
      };

      shell = { program = "${pkgs.zsh}/bin/zsh"; };
    };
  };
}
