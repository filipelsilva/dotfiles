{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    texliveFullWithDocs
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
  ];
}
