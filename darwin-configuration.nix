{ config, pkgs, ... }:

{
  homebrew.enable = true;

  homebrew.casks = [
    "visual-studio-code@insiders"
    "cursor"
    "aldente"
    "raycast"
    "shottr"
    "betterdisplay"
    "notchnook"
    "obs"
  ];

  homebrew.brews = [
    "bore-cli"
  ];

  programs.zsh.enable = true;

  ids.gids.nixbld = 350;

  system.stateVersion = 4;
}

