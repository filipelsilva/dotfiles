{ pkgs, inputs, ... }:
{
  programs.tmux.enable = true;

  environment.systemPackages = with pkgs; [
    screen
  ];

  homeConfig =
    { config, ... }:
    {
      home.packages = [
        (pkgs.writeShellScriptBin "tms" (
          builtins.readFile "${inputs.self}/dotfiles/scripts/tmux-sessionizer.sh"
        ))
      ];
      home.file = {
        ".screenrc".source = "${inputs.self}/dotfiles/headless/screen/.screenrc";
        ".tmux.conf".source = "${inputs.self}/dotfiles/headless/tmux/.tmux.conf";
      };
    };
}
