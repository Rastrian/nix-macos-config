{
  description = "Nix flake for macOS setup using nix-darwin and Home Manager (Rastrian's config)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      system = "aarch64-darwin";  # MacBook M1/M2/M3
      darwinSystem = nix-darwin.lib.darwinSystem;
    in {
      darwinConfigurations = {
        macbook = darwinSystem {
          inherit system;
          modules = [
            ./darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # 🛠️ FIX: Set username and home directory manually here
              users.users.rastrian = {
                home = "/Users/rastrian";
                shell = "/run/current-system/sw/bin/zsh"; # optional: set default shell
              };

              home-manager.users.rastrian = {
                home.username = "rastrian";
                home.homeDirectory = "/Users/rastrian";
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}

