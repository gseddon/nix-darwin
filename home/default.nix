{ config, primaryUser, ... }:
{
  imports = [
    ./packages.nix
    ./misc-programs.nix
    ./shell.nix
    ./mise.nix
    ./vim.nix
    ./git.nix
    ./ssh.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      # shared environment variables
      SSH_AUTH_SOCK="${config.home.homeDirectory}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";

    # Cocoa text system (Safari, Notes, Slack, …). ~ is Option.
    # Does not apply to Kitty, Cursor, or other non-NSTextView apps.
    file."Library/KeyBindings/DefaultKeyBinding.dict".source = ./DefaultKeyBinding.dict;
  };
}
