{ ... }:
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
      "android-studio"
      "claude"
      "karabiner-elements"
      "kiro"
      "obsidian"
      "raycast"
      "monitorcontrol"
      "whatsapp"
      "visual-studio-code"
      #"betterdisplay"
    ];
    brews = [
      "emacs-plus"
    ];
    taps = [
      "d12frosted/emacs-plus"
    ];
  };
}
