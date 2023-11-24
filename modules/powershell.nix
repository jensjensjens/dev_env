{ config, pkgs, ... }:
{
    xdg.configFile.powershell-profile = {
        target = "powershell/Microsoft.PowerShell_profile.ps1";
        text = ''
            Invoke-Expression (&starship init powershell)

            Set-PSReadLineOption -EditMode Vi
            Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Insert
            Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Command

            if (-not (Get-Module PSFzf -ListAvailable)) {
                write-output "installing psfzf"
                install-module -name psfzf -scope currentuser -force
            }
            Import-Module PSFzf
            Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
        '';
    };
}
