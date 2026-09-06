{ ... }:
let
  padel_apps = [
    "android-studio"
  ];
in
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    global.brewfile = true;

    casks = [
      "1password"
      "claude-code@latest"
      "claude"
      "chatgpt"
      "karabiner-elements"
      "kitty"
      "obsidian"
      "raycast"
      "monitorcontrol"
      "whatsapp"
      {
        name = "d12frosted/emacs-plus/emacs-plus-app";
        trusted = true;
      }
      #"betterdisplay"
    ] ++ padel_apps;
    brews = [
      "displayplacer"
      "hatch"
      "openjdk@21" # sudo ln -sfn $HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
      "swiftgen"   # iOS code generation from resources
      "yq"
    ];
    taps = [
      "d12frosted/homebrew-emacs-plus"
    ];
  };
}
