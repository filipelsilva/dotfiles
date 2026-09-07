{
  lib,
  inputs,
  config,
  ...
}:
{
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
      download-buffer-size = 1024 * 1024 * 1024;
      trusted-users = [ "@wheel" ];
    };
    optimise = {
      automatic = true;
      persistent = true;
      dates = "weekly";
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  services.envfs.enable = true;

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    pathsToLink = [ "/libexec" ];
  };
}
