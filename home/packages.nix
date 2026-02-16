{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      awscli2
      # curl
      # direnv
      fzf
      tmux
      htop
      tree
      ripgrep
      act
      bat
      yq

      sshpass

      # programming languages
      # mise # node, deno, bun, rust, python, etc.

      # misc
      nil
      #biome
      nixfmt-rfc-style
      yt-dlp
      ffmpeg
      #ollama
      _1password-cli

      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      jetbrains-mono
    ];
  };
}
