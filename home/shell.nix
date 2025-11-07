_: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -la";
      ".." = "cd ..";
      "nix-switch" = "sudo darwin-rebuild switch --flake /etc/nix-darwin/.config/nix";
    };
   oh-my-zsh = {
         enable = true;
         plugins = [
            "aws"
            "direnv"
            "fzf"
            "git"
            "z"
         ];
         theme = "agnoster";
         extraConfig = ''

           #source $HOME/.config/zsh/scripts/aliases
           # this fpath extension is for local completions such as RDE
           #fpath=(~/.zsh_completion $fpath)
           '';
       };
    initContent = ''
     # do not show prompt in agnoster https://stackoverflow.com/a/28492373
     prompt_context() {}
     '';
    history = {
     size = 50000;
     save = 50000;
    };

  };
}
