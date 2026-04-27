{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    vim # or some other editor, e.g. nano or neovim
    openssh
    # Some common stuff that people expect to have
    #procps
    killall
    #diffutils
    #findutils
    utillinux
    #tzdata
    #hostname
    man
    gnugrep
    #gnupg
    #gnused
    #gnutar
    #bzip2
    #gzip
    #xz
    zip
    unzip
    #_0xproto
    nerd-fonts._0xproto
    #(nerdfonts.override { fonts = [ "_0xproto" ]; }) 
    #_0xproto
  ];
  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";
  #services.xserver.windowManager.dwm.enable = true;

  # Read the changelog before changing this value
  system.stateVersion = "24.05";
  user = {
    shell = "${lib.getExe pkgs.zsh}";
  };
  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  terminal.font = "${pkgs.nerd-fonts._0xproto}/share/fonts/truetype/NerdFonts/0xProto/0xProtoNerdFontMono-Regular.ttf";
  terminal.colors = {
    background = "#24273A";
    foreground = "#cad3f5";
    cursor = "#c6a0f6";
    color0 = "#494d64";
    color8 = "#5b6078";
    color1 = "#ed8796";
    color9 = "#ed8796";
    color2 = "#a6da95";
    color10 = "#a6da95";
    color3 = "#eed49f";
    color11 = "#eed49f";
    color4 = "#8aadf4";
    color12 = "#8aadf4";
    color5 = "#f5bde6";
    color13 = "#f5bde6";
    color6 = "#8bd5ca";
    color14 = "#8bd5ca";
    color7 = "#b8c0e0";
    color15 = "#a5adcb";
  }; 
  # Set your time zone
  #time.timeZone = "Europe/Berlin";
  # Configure home-manager
  home-manager = {
    config = ./home.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
  };
}
