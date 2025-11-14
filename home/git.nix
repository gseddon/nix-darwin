{ config, ... }:
{
  programs.git = {
    enable = true;
    lfs = {
      enable = true;
      skipSmudge = true;
    };
    ignores = [
      ".idea"
      "*.code-workspace"
      ".vscode"
      "**/.DS_Store"
    ];
    settings = {
      user = {
        # Set in local machine configuration now
        # email = "gareth.seddon@gmail.com";
        name = "Gareth Seddon";
      };
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        push-new-branch = "push -u origin HEAD";
        root = "rev-parse --show-toplevel";
        dag = "log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)%an <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order";
      };
      core = {
        attributesfile = "${config.home.homeDirectory}/.gitattributes";
      };
      color.ui = "auto";
      push.default = "simple";
      rebase.autostash = "true";
    };
  };
}
