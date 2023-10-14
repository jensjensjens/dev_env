{ config, pkgs, ... }:

{
  imports = [
      ./packages.nix
      ./alacritty.nix
      ./git.nix
      ./tmux.nix
      ./zsh.nix
      
      # ./i3/i3.nix
  ];
  home = {
      stateVersion = "23.11";
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";

      sessionVariables = {
          DOCKER_BUILDKIT = 1;
          MANPAGER = "page -t man";
          PAGER = "page";
          PULUMI_SKIP_UPDATE_CHECK = "true";
      };

      shellAliases = {
          watch = "${pkgs.viddy}/bin/viddy";
	        tree = "${pkgs.eza}/bin/exa --all --tree --ignore-glob '__pycache__|node_modules|.git|venv|obj' --icons --sort type";
          config = "${pkgs.git}/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
          configui = "${pkgs.gitui}/bin/gitui -d $HOME/.cfg -w $HOME";
      };

      file = {
        bin = {
          source = ./. + "/bin";
          target = "bin";
        };
      };
  };

  # Copy over the gitui config files
  xdg = {
    configFile = {
      gitui = {
        source = ./. + "/gitui";
      };

      starship = {
        source = ./. + "/starship.toml";
        target = "starship.toml";
      };
    };
  };

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [
          "-p 80%,60%"
        ];
      };
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "zenburn";
      };
    };

    eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };

    k9s = {
      enable = true;
    };

    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };
  };
}
