{ primaryUser, pkgs, config, ... }:
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
}
