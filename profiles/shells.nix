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
        ".inputrc".source =
          config.lib.file.mkOutOfStoreSymlink "${inputs.self}/dotfiles/headless/readline/.inputrc";
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/dotfiles/headless/zsh/.zshrc";
      };
    };
}
