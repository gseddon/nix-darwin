## Gareth's Nix setup

Heavily based on https://github.com/bgub/nix-macos-starter/blob/main/README.md


To get started, just do something like
```
git clone https://github.com/gseddon/nix-darwin.git /etc/nix-darwin
sudo darwin-rebuild switch --flake /etc/nix-darwin#macbook-air
```