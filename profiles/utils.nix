{
  pkgs,
  headless,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    [
      binutils
      coreutils
      diffutils
      diffoscope
      findutils
      iputils
      inetutils
      moreutils
      pciutils
      psmisc
      basez
      procps
      bottom
      lm_sensors
      nvtopPackages.full
      tree
      bc # Calculator
      ascii
      cht-sh
      tealdeer
      (lib.hiPrio parallel)
      haskellPackages.words
    ]
    ++ lib.lists.optionals (!headless) (
      with pkgs;
      [
        qFlipper
      ]
    );

  hardware.flipperzero.enable = true;

  programs = {
    htop.enable = true;
  };

  services = {
    sysstat.enable = true;
    rsyncd.enable = true;
    locate = {
      enable = true;
      package = pkgs.plocate;
    };
    lact.enable = !headless;
  };

  homeConfig = {
    home.file = {
      ".config/tealdeer/config.toml".text = ''
        [updates]
        auto_update = true
      '';
    };
  };
}
