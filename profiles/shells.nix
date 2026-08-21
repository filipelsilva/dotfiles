{ pkgs, inputs, ... }:
{
  environment.shellAliases = { };

  environment.systemPackages = with pkgs; [
    bash-completion
    nix-bash-completions
    zsh-completions
    nix-zsh-completions
  ];

  programs = {
    bash = {
      shellAliases = { };
    };
    zsh = {
      enable = true;
      setOptions = [ ];
    };
  };

  homeConfig =
    { config, ... }:
    {
      home.file = {
        ".inputrc".source = "${inputs.self}/dotfiles/headless/readline/.inputrc";
        ".zshrc".source = "${inputs.self}/dotfiles/headless/zsh/.zshrc";
      };
    };
}
