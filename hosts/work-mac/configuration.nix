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
    kubecolor
    go-task
    # testkube
    playwright-test
  ];
  ios-brews = [
    "swiftlint"
    "swiftgen"
    "xcbeautify"
    "xcode-build-server"
  ];
  ios-packages = with pkgs; [
    (ruby_3_4.withPackages (ps: with ps; [ bundler ]))
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
    "aws-vpn-client"
    "codex-app"
    "iterm2"
    "whatsapp"
  ];
  homebrew.taps = [
    { name = "atlassian/homebrew-acli"; trusted = true; }
    "axon-rto/tap"
    "common-fate/granted"
    "azure/kubelogin"
  ];
  homebrew.brews = [
    { name = "helm@3"; link = true; }
    "kubectl"
    "azure-cli"
    { name = "azure/kubelogin/kubelogin"; trusted = true; }
    "tilt"
    "kubeconform"
    "testkube"
    "jq"
    "acli"
    "gh"
    "switchaudio-osx"
    "terminal-notifier"
    "git-filter-repo"
    "libqalculate"
    "vercel-cli"
    "rtk"
    "granted"
  ] ++ ios-brews;

  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      go
      android-tools
      yarn
      #graphite-cli
    ] ++ tilt-packages ++ tf-packages ++ ios-packages;

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
