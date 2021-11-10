{
  description = "Guile 3";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = inputs@{ self, nixpkgs, ... }: {
    packages.x86_64-linux.guile3 = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      version = "3.0.7";
    in pkgs.stdenv.mkDerivation {
      inherit version;
      pname = "guile3";

      nativeBuildInputs = with pkgs; [
        boehmgc
        gcc
        gmp
        gnumake
        libffi
        libunistring
        pkgconfig
      ];

      # fetchtarball throws an error for some reason, but this works just as well
      src = pkgs.fetchurl {
        url = "https://ftp.gnu.org/gnu/guile/guile-${version}.tar.gz";
        sha256 = "1bjn6sl9i591s4n8fgrhk71jil57zwhcydaxlgv4697455x5p4y7";
      };
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.guile3;
  };
}
