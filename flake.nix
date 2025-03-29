{
  description = "Tmux built from latest master commit";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tmux-src = {
      url = "github:tmux/tmux/master";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, tmux-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.tmux.overrideAttrs (oldAttrs: {
          version = "master-${builtins.substring 0 7 tmux-src.rev}";
          src = tmux-src;
        });
      }
    );
}
