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
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

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

#  home.activation.dotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
#    if [ ! -d "${config.home.homeDirectory}/.cfg/.git" ]; then
#      #$DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/gseddon/dotfiles.git /tmp/dotfiles
#      /usr/bin/git clone git@github.com:gseddon/dotfiles.git /tmp/dotfiles
#      mv /tmp/dotfiles/.git "${config.home.homeDirectory}/.cfg"
#       config config --local status.showUntrackedFiles no
#    fi
#  '';
}
