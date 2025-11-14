{ ... }:
let
  padel_apps = [
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
      #"1password"
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
      "emacs-plus"
    ];
    taps = [
      "d12frosted/homebrew-emacs-plus"
    ];
  };
}
