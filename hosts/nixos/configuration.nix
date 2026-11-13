{ config, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (import ../../overlays/thunar-xarchiver.nix)
  ];

  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
    ../../modules/fonts.nix
  ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time and locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # User
  users.users."zenit" = {
    isNormalUser = true;
    description = "zenit";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Nix
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    substituters = [
      "https://cache.nixos.org"
      "https://niri.cachix.org"
      "https://noctalia.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Base system packages (user apps live in home/zenit.nix)
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    binutils
    tree-sitter
    ctags
    unzip
    tree
    ripgrep
    p7zip
  ];

  programs.nix-ld.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  system.stateVersion = "26.05";
}
