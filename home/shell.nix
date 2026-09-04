_: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -la";
      ".." = "cd ..";
      "nix-switch" = "sudo darwin-rebuild switch --flake /etc/nix-darwin#macbook-air";
      assume = "source /opt/homebrew/bin/assume";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aws"
        "azure"
        # "direnv"
        "fzf"
        "git"
      ];
      theme = "agnoster";
      extraConfig = ''
        SHOW_AWS_PROMPT=false # suppress aws plugin's <aws:profile> <region:...> in RPROMPT
        ZSH_DISABLE_COMPFIX="true"
        DISABLE_AUTO_UPDATE="true"
        DISABLE_MAGIC_FUNCTIONS="true"
        ZSH_AUTOSUGGEST_USE_ASYNC=1
        AGNOSTER_GIT_BRANCH_STATUS=false
        DISABLE_UNTRACKED_FILES_DIRTY=true
      '';
    };
    initContent = ''
      # do not show prompt in agnoster https://stackoverflow.com/a/28492373
      prompt_context() {}
      source ${./shell-functions.sh}
    '';
    history = {
      size = 50000;
      save = 50000;
    };

  };
}
