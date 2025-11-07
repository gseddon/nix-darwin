{ self, ... }:
{
  # touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # 120 minutes to re-auth
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=120
  '';

  # system defaults and preferences
  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;

    #startup.chime = false;


    defaults = {
      loginwindow = {
        GuestEnabled = false;
        #DisableConsoleAccess = true;
      };

      finder = {
        AppleShowAllFiles = true; # hidden files
        AppleShowAllExtensions = true; # file extensions
        _FXShowPosixPathInTitle = true; # title bar full path
        ShowPathbar = true; # breadcrumb nav at bottom
        ShowStatusBar = true; # file count & disk space
      };

      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        ApplePressAndHoldEnabled = false;
        # TODO can I do caps lock ctrl here?
      };
    };
  };
}
