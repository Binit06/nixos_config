final: prev: {
  thunar-archive-plugin = prev.thunar-archive-plugin.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        mkdir -p "$out/libexec/thunar-archive-plugin"
        cp -a ${prev.xarchiver}/libexec/thunar-archive-plugin/. \
        "$out/libexec/thunar-archive-plugin/"
      '';
  });
}
