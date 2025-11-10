{ ... }:
let
  padel_apps = [
    "android-studio"
    "genymotion"
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
      "karabiner-elements"
      "kiro"
      "obsidian"
      "raycast"
      "monitorcontrol"
      "whatsapp"
      "visual-studio-code"
      #"betterdisplay"
    ] ++ padel_apps;
    brews = [
      "emacs-plus"
    ];
    taps = [
      "d12frosted/emacs-plus"
    ];
  };
}
