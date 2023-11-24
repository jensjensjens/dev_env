{
  description = "Home Manager configuration of jenss";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."jenss" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ 
            ./home.nix
            ./packages.nix 

            ./modules/alacritty.nix 
            ./modules/bat.nix
            ./modules/bin.nix
            ./modules/editorconfig.nix
            ./modules/eza.nix
            ./modules/fzf.nix
            ./modules/gh.nix
            ./modules/git.nix 
            ./modules/gitui.nix
            ./modules/k9s.nix
            ./modules/neovim.nix
            ./modules/nix.nix
            ./modules/powershell.nix
            ./modules/ssh.nix
            ./modules/starship.nix
            ./modules/tmux.nix 
            ./modules/virt-manager.nix
            ./modules/zsh.nix 
        ];
      };
    };
}
