# user level configuration
{ config, pkgs, inputs, ... }:
{
    home.username = "zenit";
    home.homeDirectory = "/home/zenit";
    home.stateVersion = "26.05";

    home.packages = with pkgs; [
        #terms & uts
        alacritty
        fastfetch
        ncdu
        wl-clipboard

        #browsing
        firefox
        brave
        discord

        #audio
        pavucontrol
        playerctl
        
        #dev
        github-cli gcc gnumake gdb python3 nodejs clang-tools
        inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-cli
        
        #misc
        lutris
        qbittorrent
    ];
    
    # handles the correct terminal to use when needed by application
    xdg.terminal-exec = {
        enable = true;
        settings = {
            default = [ "Alacritty.desktop" ];
        };
    };

    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "text/plain" = "nvim.desktop";
            "application/pdf" = "firefox.desktop";
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

    qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style = {
            name = "adwaita-dark";
            package = [pkgs.adwaita-qt pkgs.adwaita-qt6];
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

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    xdg.configFile."gtk-4.0/gtk.css".force = true;
    xdg.configFile."mimeapps.list".force = true;
}
