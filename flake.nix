{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    skyrim.url = "github:Rucadi/NixSkyrimAE";
  };
  outputs = { self, nixpkgs, skyrim }:
    let
      nexus_mods_cookie = "";
      system = "x86_64-linux";
      modlist_name = "skyrimse";
      pkgs = import nixpkgs { inherit system; };
      skyrim_mods = import skyrim { inherit system pkgs nexus_mods_cookie modlist_name; lib=nixpkgs.lib;};
    in
    rec {
      packages.x86_64-linux.default = pkgs.buildEnv {
        name = "my-packages";
        paths = [ 
          skyrim_mods.RaceMenu 
          skyrim_mods.SKSE
          skyrim_mods.USSEP
          skyrim_mods.SKYRIM202X_1
          skyrim_mods.SKYRIM202X_2
          skyrim_mods.SKYRIM202X_3
          
          ];
        ignoreCollisions = true;
      };
    };
}