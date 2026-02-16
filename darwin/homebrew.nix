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
      "claude-code"
      "chatgpt"
      "karabiner-elements"
      "kitty"
      "kiro"
      "obsidian"
      "raycast"
      "monitorcontrol"
      "whatsapp"
      "visual-studio-code"
      #"betterdisplay"
    ] ++ padel_apps;
    brews = [
      "displayplacer"
      "hatch"
      "emacs-plus"
      "openjdk@21" # sudo ln -sfn $HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk   
    ];
    taps = [
      "d12frosted/homebrew-emacs-plus"
    ];
  };
}
