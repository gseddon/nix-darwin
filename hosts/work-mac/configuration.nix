{
  pkgs,
  primaryUser,
  ...
}:
let
  tilt-packages = with pkgs; [
    tilt
    kubernetes-helm
    kubeconform
    kubectl
    kubelogin
    go-task
    gh
    awscli
    azure-cli
  ];
in
{
  networking.hostName = "EU-JPW5QPV4P4";

  # host-specific homebrew casks
  homebrew.casks = [
    #"bettertouchtool"
    "cursor"
  ];

  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      #graphite-cli
    ] ++ tilt-packages;

    programs = {
      git.settings.user.email = "gseddon@axon.com";
      zsh = {
        initContent = ''
          # Source shell functions
          source ~/.secrets
        '';
      };
    };
  };
}
