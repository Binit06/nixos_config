final: prev: {
    btop = prev.btop.overrideAttrs(old: {
        postInstall = (old.postInstall or "") + ''
            substituteInPlace $out/share/applications/btop.desktop \
            --replace-fail 'Exec=btop' 'Exec=btop --force-utf'
        '';
    });
}
