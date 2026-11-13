# Frequently used commands in nix

## System Rebuilds
- Rebuild & activate = `sudo nixos-rebuild switch --flake .#nixos`
- Build without activating = `nixos-rebuild build --flake .#nixos`
- Temporarily test configuration = `sudo nixos-rebuild test --flake .#nixos`
- Dry build (check what would be built) = `nixos-rebuild dry-build --flake .#nixos`

## Package Management & Inspection
- Build package from your flake = `nix build .#<package>`
- Check upstream package version = `nix eval --raw nixpkgs#<package>.version`
- Check overlaid package store path = `nix eval --raw .#nixosConfigurations.nixos.pkgs.<package>.outPath`
- Find which package provides a file = `nix-locate <filename>`
- Search packages = `nix search nixpkgs <package>`
- Inspect package attributes = `nix eval nixpkgs#<package> --json`

## Store & Disk Management
- Check storage usage = `du -sh <path>`
- Show package dependencies (recursive) = `nix path-info -r <store-path>`
- Show closure size = `nix path-info -Sh <store-path>`
- Garbage collect unused store paths = `sudo nix-collect-garbage`
- Delete old generations (older than 7 days) = `sudo nix-collect-garbage --delete-older-than 7d`

## Flake Management
- Show flake outputs = `nix flake show`
- Update all inputs = `nix flake update`
- Update one input = `nix flake update nixpkgs`
- Update one input in lock file = `nix flake lock --update-input nixpkgs`

## Temporary Environments
- Enter temporary package shell = `nix shell nixpkgs#gcc`
- Run package without installing = `nix run nixpkgs#fastfetch`
- Enter development environment = `nix develop`
- Enter dev shell using Bash = `nix develop --command bash`

## System Information & Troubleshooting
- See current system generation = `readlink /run/current-system`
- List system generations = `sudo nixos-rebuild list-generations`
- List failed systemd services = `systemctl --failed`
- Check service status = `systemctl status <service>`
- Check current boot service logs = `journalctl -u <service> -b`
- Show current boot errors = `journalctl -p err -b`
- Show previous boot logs = `journalctl -b -1`


