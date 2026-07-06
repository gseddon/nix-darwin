{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "Gareths-Macbook-Air";

  # host-specific homebrew casks
  homebrew.casks = [
    # "slack"
    "android-studio"
    "http-toolkit"
    "qbittorrent"
    "genymotion"
  ];

  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      ffmpeg
    ];

    programs = {
      git.settings.user.email = "gareth.seddon@gmail.com";
    };
  };
}
