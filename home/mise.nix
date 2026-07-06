{ ... }:
{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    globalConfig = {
      settings = {
        experimental = false;
        verbose = false;
        auto_install = true;
        idiomatic_version_file_enable_tools = [ ];
      };

      env = {
        MISE_NODE_COREPACK = true;
      };

      tools = {
        node = "22.22.0";
        uv = "latest";
        # rust = "stable";
      };
    };
  };
}
