# Nix macOS Config

This repository contains my personal macOS setup using [Nix](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin), and [Home Manager](https://github.com/nix-community/home-manager).

It installs:

- Homebrew apps (GUI and CLI)
- Programming tools (Git, Docker, Colima, Python 3, etc.)
- Shell setup (Oh-My-Zsh and Fish)
- Git and SSH auto-configuration

## Quick Install Guide

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Nix

```bash
curl -L https://nixos.org/nix/install | sh
```

Enable flakes and nix-command:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

### 3. Clone this repository

```bash
git clone https://github.com/rastrian/nix-macos-config.git
cd nix-macos-config
```

### 4. Apply the configuration

```bash
nix run github:LnL7/nix-darwin -- switch --flake .#macbook
```

### Troubleshooting

If you see an error about nixbld GID mismatch, it is already handled inside `darwin-configuration.nix` by setting `ids.gids.nixbld = 350`.

