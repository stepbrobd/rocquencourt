{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/f348a2b7e31beb5c288e4d8af4b36917522af799";

  outputs = { nixpkgs, ... }: {
    legacyPackages =
      let
        inherit (nixpkgs) lib;

        forAllSystems = lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          # "aarch64-darwin"
        ];

        allowedPrefixes = [
          "coqPackages_8_20"
          "coqPackages_9_0"
          "coqPackages_9_1"
          "coqPackages_9_2"

          "rocqPackages_9_0"
          "rocqPackages_9_1"
          "rocqPackages_9_2"
        ];

        pkgsFor =
          system:
          import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
      in
      forAllSystems (system: lib.genAttrs allowedPrefixes (prefix: (pkgsFor system).${prefix}));
  };

  nixConfig.extra-substituters = [ "https://cache.ysun.co" ];
  nixConfig.extra-trusted-public-keys = [
    "cache.ysun.co-1:WxPYwT5g3kt9XhUhHPpNLZKI9HIOsVVAuqSHpok8Qt4="
  ];
}
