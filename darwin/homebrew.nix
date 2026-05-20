{ ... }:
let
  padel_apps = [
    "android-studio"
    "http-toolkit"
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

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    casks = [
      "1password"
      "chatgpt"
      "karabiner-elements"
      "kitty"
      "kiro"
      "obsidian"
      "raycast"
      "monitorcontrol"
      "whatsapp"
      "visual-studio-code"
      { name = "emacs-plus-app"; args = { no_quarantine = false; }; }
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
