# TODOs

## Bootstrapping
- Set up sops during bootstrapping and store the ssh keys and age keys; investigate if ssh keys will suffice instead of age keys
- Harden SSH: First in nixos-anywhere, give my user passwordless sudo, disable root password. Then in deploy-rs change sshuser to nikhil.

## Basics
- Set variables that are used throughout the configs like "hetzner", "nikhilmaddirala", "networking.hostName", etc.
- Add xdg base dirs - issue with compatability
- Rosetta builder: https://github.com/cpick/nix-rosetta-builder

## Seasmoke
- Managing boilerplate configs for multiple services
- Obsidian: consider switching to linuxserver image

# SCRATCH