{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        hello = pkgs.stdenv.mkDerivation
          {
            name = "hello";
            version = "0.0.1";
            src = pkgs.fetchFromGitHub {
              owner = "jademackay";
              repo = "hello";
              rev = "60210f2dbe9acd49197f1fe505d5ee7de79650e4";
              hash = "sha256-a7IOx7kq/ahZvteuWZ2ki7niLgXWJOqJNmiCd80HO+k=";
            };

            # phases = [ "unpackPhase" "buildPhase" "installPhase" ];
            # nativeBuildInputs = [ ];
            # buildInputs = [ ];
            # buildPhase = ''
            # '';
            installPhase = ''
              mkdir -p $out/bin
              cp $src/hello.sh $out/bin/hello.sh
            '';

            meta = {
              homepage = "https://github.com/jademackay/hello";
              mainProgram = "hello.sh";
              platforms = pkgs.lib.platforms.linux;
              license = pkgs.lib.licenses.unlicense;
            };
          };

      in
      {
        packages = {
          inherit hello;
          default = hello;
        };
      }
    );
}
