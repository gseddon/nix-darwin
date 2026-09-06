{
  description = "Gareth's nix-darwin system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # manages configs
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # declarative homebrew management
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # terraform versions
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";

    # translation-v2 application dependencies
    # translation-v2.url = "git+ssh://git@git.taservs.net/rto/translation-v2.git";
    # translation-v2.url = "path:/Users/gseddon/git/translation-v2";
    # translation-v2.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-substituters = "https://nixpkgs-terraform.cachix.org";
    extra-trusted-public-keys = "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw=";
  };

    outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      nixpkgs-terraform,
      ...
    }@inputs:
    let
      primaryUser = "gseddon";
      mkDarwin = name:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./darwin
            ./hosts/${name}/configuration.nix
          ];
          specialArgs = {
            inherit inputs self primaryUser;
            darwinFlakeAttr = name;
          };
        };
    in
    {
      darwinConfigurations = nixpkgs.lib.genAttrs [ "macbook-air" "work-mac" ] mkDarwin;
    };
}
