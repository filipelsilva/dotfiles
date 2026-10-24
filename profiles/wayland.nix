{
  config,
  pkgs,
  ...
}:
let
  nixosConfig = config;

  bliss = pkgs.fetchurl {
    url = "https://archive.org/download/bliss-600dpi/bliss-600dpi.png";
    sha256 = "a72d44ee40c406a1b8837a94e7fc8834bd7f6f22e8c5da9aa28da9d5922d47da";
  };
  blissNew = pkgs.fetchurl {
    url = "https://msdesign.blob.core.windows.net/wallpapers/Microsoft_Nostalgic_Windows_Wallpaper_4k.jpg";
    sha256 = "8f9a38bfc0f5670eb8d92e92539719c1086abee4313930f4ad1fd1e7ad6d305e";
  };

  start_command = "niri-session";
in
{
  security.pam.services.swaylock = { };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    xwayland-satellite # xwayland support

    waybar
    rofi

    swayidle
    swaylock

    wlr-randr
    wlr-which-key # sway-mode replacement menus for niri
    wdisplays
    shikane # run: shikanectl export <name_of_config> > ~/.config/shikane/config.toml
    swaybg # wallpaper

    dunst
    libnotify

    wl-clipboard

    batsignal # Battery status

    brightnessctl

    # Theme management
    glib # gsettings
    gnome-themes-extra
    adwaita-icon-theme
    adwaita-icon-theme-legacy
    lxappearance
    libsForQt5.qt5ct

    wev # Check keyboard events
    dragon-drop # Drag-and-drop source/sink
    tigervnc # VNC server/client
    remmina # Remote desktop client
    scrcpy # Android screen mirroring and control
    uxplay # AirPlay server
    piper # Gaming mouse configuration
    hyprpicker # Color picker
  ];

  programs = {
    dconf.enable = true;
    niri = {
      enable = true;
      useNautilus = true;
    };
  };

  # NixOS otherwise injects a stripped PATH via Environment= on the niri.service
  # unit which shadows the imported user-manager PATH. Disabling the default
  # lets niri inherit the full PATH set up by niri-session.
  systemd.user.services.niri.enableDefaultPath = false;

  security.polkit = {
    enable = true;
    enablePkexecWrapper = true;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    enable = true;
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  systemd.user.services.swaybg = {
    description = "Wallpaper";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.swaybg}/bin/swaybg --mode fill --image ${bliss}";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    ratbagd.enable = true;
    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --time-format '%A, %d %B %Y - %H:%M:%S' --cmd '${start_command}'";
          user = "greeter";
        };
      };
    };
    logind.settings.Login = {
      # don’t shutdown when power button is short-pressed
      HandlePowerKey = "suspend";
      HandleLidSwitch = "suspend";
    };
  };

  userConfig.extraGroups = [ "video" ];

  homeConfig =
    { config, ... }:
    {
      home.file = {
        ".config/i3status".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/desktop/i3/.config/i3status";
        ".config/niri".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/desktop/niri/.config/niri";
        ".config/waybar".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/desktop/waybar/.config/waybar";
        ".config/wlr-which-key".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/desktop/wlr-which-key/.config/wlr-which-key";
        ".config/dunst".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/desktop/dunst/.config/dunst";
      };

      services.gammastep = {
        enable = true;
        provider = "manual";
        latitude = nixosConfig.location.latitude;
        longitude = nixosConfig.location.longitude;
      };
    };
}
