{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      curl
      direnv
      fzf
      tmux
      htop
      tree
      ripgrep
      gh

      # programming languages
      mise # node, deno, bun, rust, python, etc.

      # misc
      nil
      #biome
      nixfmt-rfc-style
      yt-dlp
      #ffmpeg
      #ollama

      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
  };
}
