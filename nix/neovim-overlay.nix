{
  inputs,
  nvimConfigPath ? ../nvim,
}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-locked = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {
    inherit (pkgs-locked) wrapNeovimUnstable neovimUtils;
    inherit nvimConfigPath;
  };

  extraPackages = with pkgs; [
    # Language servers
    nodePackages_latest.bash-language-server
    clang-tools
    nodePackages_latest.dockerfile-language-server-nodejs
    efm-langserver
    gopls
    nodePackages_latest.vscode-langservers-extracted

    jdt-language-server
    (pkgs.writeShellScriptBin "jdtls" "jdt-language-server \"$@\"")

    lua-language-server
    nil
    pyright

    rust-analyzer
    terraform-ls
    texlab
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vim-language-server

    # Other stuff
    tree-sitter
  ];
in {
  nvim-pkg = mkNeovim {
    inherit extraPackages;
  };
}
