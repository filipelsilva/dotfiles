{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    pandoc
    zathura
    diffpdf
    img2pdf
  ];

  homeConfig =
    { config, ... }:
    {
      home.file = {
        ".config/zathura/zathurarc".source =
          "${inputs.self}/dotfiles/desktop/zathura/.config/zathura/zathurarc";
      };
    };
}
