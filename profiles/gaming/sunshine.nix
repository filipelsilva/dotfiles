{ ... }: {
  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  userConfig.extraGroups = [ "uinput" ];
  hardware.uinput.enable = true;
}
