{ pkgs, inputs, ... }:
{
  imports = [ inputs.noctalia.nixosModules.default ];

  programs.niri.enable = true;
  programs.noctalia.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  programs.xfconf.enable = true;
  programs.dconf.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
      user = "greeter";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = ["gtk" "gnome"];
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    brightnessctl
    xdg-utils
    glib
    gsettings-desktop-schemas
    adwaita-icon-theme
  ];
}
