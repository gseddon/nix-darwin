{ ... }:
let
  padel_apps = [
    "android-studio"
    "genymotion"
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
      "claude"
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
    ];
    brews = [
      "hatch"
      "emacs-plus"
      "openjdk@21" # sudo ln -sfn $HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk   
    ];
    taps = [
      "d12frosted/homebrew-emacs-plus"
    ];
  };
}
