This is my multi system nix config, which currently manages the following systems

- desktop
- server
- media server
- macbook

To build for nixos:

sudo nixos-rebuild switch --flake .#system


To build for macbook:

sudo darwin-rebuild switch --flake .