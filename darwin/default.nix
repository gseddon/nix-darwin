{
  pkgs,
  inputs,
  self,
  primaryUser,
  config,
  ...
}:
{
  imports = [
    ./homebrew.nix
    ./settings.nix
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  # nix config
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # disabled due to https://github.com/NixOS/nix/issues/7273
      # auto-optimise-store = true;
      extra-sandbox-paths = [
        "${config.home.homeDirectory}/.secrets"
      ];
    };
    enable = false; # using determinate installer
  };

  nixpkgs.config.allowUnfree = true;
  
  # Overlay to prevent fish from being built
  # should be able to fix once https://github.com/NixOS/nixpkgs/tree/nixpkgs-unstable/pkgs/by-name/fi/fish
  # has https://github.com/NixOS/nixpkgs/pull/461779 merged
  nixpkgs.overlays = [
    (final: prev: {
      fish = prev.stdenv.mkDerivation {
        name = "fish-disabled";
        version = "disabled";
        dontUnpack = true;
        dontBuild = true;
        installPhase = ''
          mkdir -p $out/bin
          echo "#!/bin/sh" > $out/bin/fish
          echo "echo 'fish is disabled in this configuration'" >> $out/bin/fish
          chmod +x $out/bin/fish
        '';
        meta = {
          description = "Disabled fish shell";
          # broken = true;
        };
      };
      
    })
  ];

  # homebrew installation manager
  nix-homebrew = {
    user = primaryUser;
    enable = true;
    autoMigrate = true;
  };

  # home-manager config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${primaryUser} = {
      imports = [
        ../home
      ];
    };
    extraSpecialArgs = {
      inherit inputs self primaryUser;
    };
  };

  # macOS-specific settings
  system.primaryUser = primaryUser;
  users.users.${primaryUser} = {
    home = "/Users/${primaryUser}";
    shell = pkgs.zsh;
  };
  environment = {
    systemPath = [
      "/opt/homebrew/bin"
    ];
    systemPackages = with pkgs; [
      libgccjit
      #curl
    ];
    pathsToLink = [ "/Applications" ];
  };

  system.activationScripts.extraActivation.text = ''
    # Link Homebrew OpenJDK for system-wide use
    if [ -d "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk" ]; then
      ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
    fi
  '';
}
