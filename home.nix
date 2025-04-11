{ pkgs, lib, config, ... }:

{
  home.username = "rastrian";
  home.homeDirectory = "/Users/rastrian";   # Manual home directory
  home.stateVersion = "24.05";              # Home Manager version

  home.packages = with pkgs; [
    git
    colima
    docker
    docker-compose
    python3
    fish
    openssh
    gh
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "docker" ];
    };
  };

  programs.fish = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Rastrian";
    userEmail = "me@rastrian.dev";
  };

  home.activation.generateSSHKey = lib.mkAfter ''
    KEY="$HOME/.ssh/id_ed25519"
    if [ ! -f "$KEY.pub" ]; then
      echo "🔑 No SSH key found. Generating new Ed25519 SSH key for Git..."
      mkdir -p "$HOME/.ssh"
      /usr/bin/ssh-keygen -t ed25519 -C "rastrian@$(/bin/hostname)" -f "$KEY" -N "" || true
      if /usr/bin/ssh-add -l >/dev/null 2>&1; then 
        /usr/bin/ssh-add "$KEY" || true
      fi
      echo "✅ SSH key generated at $KEY. Here is your public key:"
      cat "$KEY.pub"
      echo "※ Add this public key to your GitHub/GitLab account."
    fi
  '';
}

