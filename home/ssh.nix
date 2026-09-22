{ config, ... }:
let
  # Quoted because of the space in "Group Containers". 1Password matches
  # IdentityFile against the public key and signs with the private key in the agent.
  identityAgent = ''"${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
in
{
  home.file.".ssh/github.pub".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAcujwjBVDvB6CFwdbyU6lbM4iut/bbwtDiCB3PDmQ4X GitHub
  '';
  home.file.".ssh/github-enterprise.pub".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKW8RjU3x4OV8wAvTS7ZpUsYh+jA9+sh9RIh9x7Yt3Pk GitHub Enterprise
  '';

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = "${config.home.homeDirectory}/.ssh/github-enterprise.pub";
        IdentityAgent = identityAgent;
      };
      "github-personal" = {
        HostName = "github.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = "${config.home.homeDirectory}/.ssh/github.pub";
        IdentityAgent = identityAgent;
      };
      "*" = {
        IdentityAgent = identityAgent;
      };
    };
  };
}
