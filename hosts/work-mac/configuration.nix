{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "EU-JPW5QPV4P4";

  # host-specific homebrew casks
  homebrew.casks = [
    "bettertouchtool"
  ];

  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      #graphite-cli
    ];

    programs = {
      zsh = {
        initContent = ''
          # Source shell functions
          source ${./shell-functions.sh}
        '';
      };
    };
  };
}
