{ primaryUser, pkgs, config, lib, ... }:
{
  programs = {
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        # tmux-sensible I should really investigate this
        resurrect
        continuum
      ];
      extraConfig = builtins.readFile ./tmux.conf;
    };

    # https://github.com/lovesegfault/nix-config/blob/master/users/bemeurer/dev/default.nix#L24
    # direnv = {
    #   enable = true;
    #   nix-direnv.enable = true;
    # };

  };
  
  home.activation.cloneSpacemacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${config.home.homeDirectory}/.emacs.d/.git" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/syl20bnr/spacemacs.git -b develop "${config.home.homeDirectory}/.emacs.d"
    fi
  '';

  home.activation.intelliMacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${config.home.homeDirectory}/.intellimacs/.git" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/MarcoIeni/intellimacs.git "${config.home.homeDirectory}/.intellimacs"
    fi
  '';

  # After linkGeneration so ~/.ssh/config exists before we clone over SSH.
  # checkout-index exits 1 when it skips existing files; don't abort activation
  # (that used to skip Home Manager's file linking, including ~/.ssh/config).
  home.activation.dotfiles = lib.hm.dag.entryAfter ["linkGeneration"] ''
    cfg="${config.home.homeDirectory}/.cfg"
    worktree="${config.home.homeDirectory}"
    git="${pkgs.git}/bin/git"

    if [ ! -e "$cfg/HEAD" ]; then
      export SSH_AUTH_SOCK="${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      export GIT_SSH_COMMAND="/usr/bin/ssh -o StrictHostKeyChecking=accept-new"
      $DRY_RUN_CMD $git clone --bare git@github-personal:gseddon/dotfiles.git "$cfg"
    fi

    export GIT_DIR="$cfg"
    export GIT_WORK_TREE="$worktree"
    $DRY_RUN_CMD $git config --local status.showUntrackedFiles no

    # Without -f, existing files are left alone. Ignore the non-zero exit.
    if [ ! -f "$cfg/index" ]; then
      $DRY_RUN_CMD $git read-tree HEAD
    fi
    $DRY_RUN_CMD $git checkout-index --all -u || true
  '';
}
