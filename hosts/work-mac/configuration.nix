{
  pkgs,
  primaryUser,
  inputs,
  ...
}:
let
  system = "aarch64-darwin";
  # Get Terraform 1.2.9 from nixpkgs-terraform
  terraform_1_2_9 = inputs.nixpkgs-terraform.packages.${system}."terraform-1.2.9";
  
  tilt-packages = with pkgs; [
    tilt
    kubernetes-helm
    kubeconform
    kubectl
    kubecolor
    kubelogin
    go-task
    gh
    awscli
    azure-cli
  ];
  tf-packages = with pkgs; [
    # I've also put terragrunt in local bin because I'm a bad person
    pnpm
    terraform_1_2_9  # Terraform 1.2.9 from nixpkgs-terraform
    tflint
    pre-commit
    terraform-ls
    hclfmt
  ];
in
{
  networking.hostName = "EU-JPW5QPV4P4";

  # host-specific homebrew casks
  homebrew.casks = [
    "cursor"
  ];
  homebrew.brews = [
    "testkube"
  ];


  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      android-tools
      #graphite-cli
    ] ++ tilt-packages ++ tf-packages;

    home.sessionVariables = {
      # https://axon.quip.com/MxymAs10jX77
      GOPROXY="https://nexus.taservs.net/repository/goproxy/";
      GONOSUMDB="git.taservs.net/*";
    };

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
