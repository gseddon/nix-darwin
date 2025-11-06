{ config, pkgs, ... }:
let
  #node_override = { nodejs = pkgs.nodejs-14_x; };

in

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs;
    [
      #awscli
      android-tools
      direnv
      expect
      fzf
      fd
      gradle
      #gitAndTools.gitflow
      git-lfs
      htop
      jq
      #kubectl
      #kubecolor
      #kubernetes-helm
      #libgccjit
      mosh
      nix-direnv
      nixfmt
      nnn
      # nodejs-14_x
      # (nodePackages.dockerfile-language-server-nodejs.override node_override)
      # (nodePackages.pyright.override node_override)
      # (nodePackages.vscode-json-languageserver.override node_override)
      # plantumlWithJar
      ripgrep
      rnix-lsp
      silver-searcher
      tmux
      tree
      vim
      watch
      watchman
      # xquartz
      # wxmac
    ];

    nixpkgs.config.allowUnfree = true;

    # environment.variables = {
    #     DIRENV_LOG_FORMAT = "";
    # };

    # enable Nix Flakes, and don't warn about dirty git directories
    nix.extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
      '';

  nixpkgs.config.packageOverrides = super: {
    python = super.python.override {
      packageOverrides = python-self: python-super: {
        # twisted = python-super.twisted.overrideAttrs (oldAttrs: {
        #   src = super.fetchPypi {
        #     pname = "twisted";
        #     version = "19.10.0";
        #     sha256 = "7394ba7f272ae722a74f3d969dcf599bc4ef093bc392038748a490f1724a515d";
        #     extension = "tar.bz2";
        #   };
        # });
        # markdown = python-super.markdown.overrideAttrs (oldAttrs: {
        #   doCheck = false;
        #   # checkPhase = "";
        # });
      };
    };
  };



  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services = {
    nix-daemon.enable = true;
  };
  # nix.package = pkgs.nix;

  security.pam.enableSudoTouchIdAuth = true;


  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    # oh-my-zsh.enable = true;
      # Configuring the below enables them in /etc/zshrc, but they get overridden
      # by ~/.oh-my-zsh/lib/key-bindings.zsh. Unsolved dilemma
      # enableFzfCompletion = true;
      # enableFzfGit = true;
      # enableFzfHistory = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
