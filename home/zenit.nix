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
        btop
        wl-clipboard

        #browsing
        firefox
        brave
        vesktop

        #fonts
        nerd-fonts.jetbrains-mono

        #audio & video
        pulseaudio
        pavucontrol
        playerctl
        mprisence
        mpv
        
        #dev
        github-cli gcc gnumake gdb python3 nodejs clang-tools
        inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-cli
        
        #misc
        lutris
        qbittorrent

        #sway
        inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.waybar
        wayfreeze
        slurp
        grim
        mako
        swayidle
        swaylock
        swaybg
        swayimg
        cliphist
        rofi
        rofimoji
        bc
    ];

    # systemd service to autoenable mprisence
    systemd.user.services.mprisence = {
        Unit = {
            Description = "Discord Rich Presence for MPRIS";
            After = [ "graphical-session.target" ];
            PartOf = [ "graphical-session.target" ];
        };

        Service = {
            ExecStart = "${pkgs.mprisence}/bin/mprisence";
            Restart = "on-failure";
            RestartSec = 5;
        };

        Install = {
            WantedBy = [ "graphical-session.target" ];
        };
    };

    services.gammastep = {
        enable = true;
        dawnTime = "6:00-7:30";
        duskTime = "18:00-19:30";
        temperature = {
            day = 3500;
            night = 3500;
        };
        settings.general = {
            fade = 1;
            brightness = 1.0;
            adjustment-method = "wayland";
        };
    };

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
            "application/x-zerosize" = "nvim.desktop";

            "application/pdf" = "firefox.desktop";
            "text/html" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "x-scheme-handler/about" = "firefox.desktop";
            "x-scheme-handler/unknown" = "firefox.desktop";

            "image/png" = "swayimg.desktop";
            "image/jpeg" = "swayimg.desktop";
            "image/gif" = "swayimg.desktop";
            "image/webp" = "swayimg.desktop";
            "image/svg+xml" = "swayimg.desktop";
            "image/bmp" = "swayimg.desktop";
            "image/tiff" = "swayimg.desktop";
            "image/avif" = "swayimg.desktop";
            "image/heic" = "swayimg.desktop";
            "image/x-icon" = "swayimg.desktop";
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
        platformTheme.name = "kvantum";
        style.name = "kvantum";
    };
    home.pointerCursor = {
        enable = true;
        name = "phinger-cursors-dark";
        package = pkgs.phinger-cursors;
        size = 24;

        gtk.enable = true;
        x11.enable = true;
    };
    fonts.fontconfig.enable = true;

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    xdg.configFile = {
        "gtk-4.0/gtk.css".force = true;
        "mimeapps.list".force = true;
        "Kvantum".source = ./dotfiles/kvantum;
        "mpv".source = ./dotfiles/mpv;
        "niri".source = ./dotfiles/niri;
        "nvim".source = ./dotfiles/nvim;
        "sway".source = ./dotfiles/sway;
        "rofi".source = ./dotfiles/rofi;
        "swayimg".source = ./dotfiles/swayimg;
        "swaylock".source = ./dotfiles/swaylock;
    };
    xdg.dataFile = {
        "fonts/Waycat.ttf".source = ./fonts/Waycat.ttf;
    };
}
