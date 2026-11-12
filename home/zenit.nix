# user level configuration
{ config, pkgs, inputs, ... }:
{
    home.username = "zenit";
    home.homeDirectory = "/home/zenit";
    home.stateVersion = "26.05";

    home.packages = with pkgs; [
        alacritty
        firefox
        fastfetch
        ncdu
        pavucontrol
        playerctl
        wl-clipboard
        github-cli

        gcc gnumake gdb python3 nodejs clang-tools
        inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-cli
    ];

    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "text/html" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "x-scheme-handler/about" = "firefox.desktop";
            "x-scheme-handler/unknown" = "firefox.desktop";
        };
    };

    gtk = {
        enable = true;
        theme = {
            name = "adw-gtk3-dark";
            package = pkgs.adw-gtk3;
        };
        gtk4.theme = config.gtk.theme;
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
        cursorTheme = {
            name = "phinger-cursors-dark";
            package = pkgs.phinger-cursors;
            size = 24;
        };
    };

    home.pointerCursor = {
        enable = true;
        name = "phinger-cursors-dark";
        package = pkgs.phinger-cursors;
        size = 24;

        gtk.enable = true;
        x11.enable = true;
    };

    dconf.settings."org/gnome/desktop/interface". color-scheme = "prefer-dark";
}
