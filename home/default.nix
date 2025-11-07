{ primaryUser, ... }:
{
  imports = [
    ./packages.nix
    ./misc-programs.nix
    ./shell.nix
    ./mise.nix
    ./vim.nix
    ./git.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";
  };
}
