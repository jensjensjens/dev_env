{ config, pkgs, ... }:

{
    home.shellAliases = {
        tree = "${pkgs.eza}/bin/eza --all --tree --ignore-glob '__pycache__|node_modules|.git|venv|obj' --icons --sort type";
    };

    programs.eza = {
        enable = true;
        enableAliases = true;
        git = true;
        icons = true;
    };
}
