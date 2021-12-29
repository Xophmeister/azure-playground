{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.11.tar.gz") {} }:

with pkgs; mkShell {
  packages = [
    terraform
    azure-cli
    jq
  ];

  shellHook = ''
    export AZURERC=".azurerc"

    [[ -e "$AZURERC" ]] || ./create-azure-sp.sh
    source "$AZURERC"

    terraform init
  '';
}
