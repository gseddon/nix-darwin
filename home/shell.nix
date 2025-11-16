_: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -la";
      ".." = "cd ..";
      "nix-switch" = "sudo darwin-rebuild switch --flake /etc/nix-darwin#macbook-air";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aws"
        "azure"
        # "direnv"
        "fzf"
        "git"
        "z"
      ];
      theme = "agnoster";
      extraConfig = ''
        ZSH_DISABLE_COMPFIX="true" # disable compaudit (slow). This  doesn't seem to work yet.
        #zmodload zsh/zprof
        #zprof

        #source $HOME/.config/zsh/scripts/aliases
        # this fpath extension is for local completions such as RDE
        #fpath=(~/.zsh_completion $fpath)
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
