{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      awscli
      # curl
      # direnv
      fzf
      tmux
      htop
      tree
      ripgrep
      act

      # programming languages
      # mise # node, deno, bun, rust, python, etc.

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
      jetbrains-mono
    ];
  };
}
