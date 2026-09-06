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
      download-buffer-size = 524288000; # 500 MiB
    };
    enable = false; # using determinate installer
  };

  nixpkgs.config.allowUnfree = true;

  # Home Manager already loads oh-my-zsh (agnoster) and runs compinit.
  # nix-darwin's defaults also run `prompt suse` (TTY device-attribute probes,
  # which print as ^[[c if the terminal is still starting) and a second
  # compinit, which slows every new interactive shell.
  programs.zsh = {
    enable = true;
    promptInit = "";
    enableGlobalCompInit = false;
    enableBashCompletion = false;
  };

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
    backupFileExtension = "hm-backup";
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
