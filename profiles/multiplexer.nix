{ pkgs, ... }:
{
  programs.tmux.enable = true;

  environment.systemPackages = with pkgs; [
    screen
  ];

  homeConfig =
    { config, ... }:
    let
      tms = pkgs.writeShellScriptBin "tms" (
        builtins.readFile "${config.home.homeDirectory}/dotfiles/dotfiles/scripts/tmux-sessionizer.sh"
      );
      tus = pkgs.writeShellScriptBin "tus" (
        builtins.readFile "${config.home.homeDirectory}/dotfiles/dotfiles/scripts/tmux-update-sessions.sh"
      );
    in
    {
      home.packages = [
        tms
        tus
      ];

      home.file = {
        ".screenrc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/headless/screen/.screenrc";
        ".tmux.conf".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/headless/tmux/.tmux.conf";
      };
    };
}
