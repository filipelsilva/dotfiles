{ pkgs, inputs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gh
  ];

  homeConfig =
    { config, ... }:
    {
      home.file = {
        ".gitconfig".source =
          config.lib.file.mkOutOfStoreSymlink "${inputs.self}/dotfiles/headless/git/.gitconfig";
      };
    };
}
