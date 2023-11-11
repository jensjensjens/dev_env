{ config, pkgs, ... }:

{
    home.file.bin = {
        source = ../. + "/bin";
        target = "bin";
    };
}
