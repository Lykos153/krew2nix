{
  description =
    "Makes kubectl plug-ins from the Krew repository accessible to Nix";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.krewIndex.url = "github:kubernetes-sigs/krew-index";
  inputs.krewIndex.flake = false;
  outputs = { self, nixpkgs, flake-utils, krewIndex }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        krewPlugins = pkgs.callPackage ./krew-plugins.nix { inherit krewIndex; };
        kubectl = pkgs.callPackage ./kubectl.nix { };
      in
      { packages = krewPlugins // { inherit kubectl; }; });
}
