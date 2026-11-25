{ pkgs, lib, inputs, ... }:
{
  imports = [ inputs.noctalia.nixosModules.default ];
    
  programs = {
      niri.enable = true;
      noctalia.enable = true;
      sway = {
          enable = true;
          wrapperFeatures.gtk = true;
          extraOptions = [ "--unsupported-gpu" ];
          extraPackages = [];
      };
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

  #obs-studio virtual camera
  programs.obs-studio.enableVirtualCamera = true;

  services = {
      greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session";
          user = "greeter";
        };
      };

      gnome.gnome-keyring.enable = true;

      udisks2.enable = true;
      gvfs.enable = true;
      tumbler.enable = true;

      power-profiles-daemon.enable = true;
      upower = {
          enable = true;
          usePercentageForPolicy = true;
          percentageLow = 20;
          percentageCritical = 10;
          percentageAction = 5;
          allowRiskyCriticalPowerAction = true;
          criticalPowerAction = "Suspend";
      };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

xdg.portal = {
  enable = true;
  wlr = {
    enable = true;
    settings = {
      screencast = {
        chooser_type = "dmenu";
        chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu -p 'Share screen'";
      };
    };
  };
  extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
  config = {
    common.default = [ "*" ];
    sway = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
    };
  };
};
  environment = {
      sessionVariables = {
          NIXOS_OZONE_WL = "1";
          XDG_CURRENT_DESKTOP = "sway";
          XDG_SESSION_TYPE = "wayland";
      };
      systemPackages = with pkgs; [
        xwayland-satellite
        brightnessctl
        xdg-utils
        xarchiver
      ];
  };
}
