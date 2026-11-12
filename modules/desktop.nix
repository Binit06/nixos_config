{ pkgs, inputs, ... }:
{
  imports = [ inputs.noctalia.nixosModules.default ];
    
  programs = {
      niri.enable = true;
      noctalia.enable = true;
      thunar = {
          enable = true;
          plugins = with pkgs; [
            thunar-archive-plugin
            thunar-volman
          ];
      };

      xfconf.enable = true;
      dconf.enable = true;
  };

  services = {
      greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      };

      gnome.gnome-keyring.enable = true;

      udisks2.enable = true;
      gvfs.enable = true;
      tumbler.enable = true;

      power-profiles-daemon.enable = true;
      upower.enable = true;
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = ["gtk" "gnome"];
  };

  environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
      systemPackages = with pkgs; [
        xwayland-satellite
        brightnessctl
        xdg-utils
        glib
        gsettings-desktop-schemas
        adwaita-icon-theme
      ];
  };
}
