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
  ];

  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      #graphite-cli
    ];

    programs = {
      git.settings.user.email = "gareth.seddon@gmail.com";
      zsh = {
        initContent = ''
          # source ${./shell-functions.sh}
        '';
      };
    };
  };
}
