{ pkgs, config, ... }:
{
    programs.fzf = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        tmux = {
            enableShellIntegration = true;
            shellIntegrationOptions = [ "-p 80%,60%" ];
        };
    };
}
