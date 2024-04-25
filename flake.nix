{
  description = "Telegram Desktop with custom patches";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          telegram-desktop-patched = pkgs.telegram-desktop.overrideAttrs (oldAttrs: {
            patches = oldAttrs.patches ++ [
              ./0001-Disable-sponsored-messages.patch
              ./0002-Disable-saving-restrictions.patch
              ./0003-Disable-invite-peeking-restrictions.patch
              ./0004-Disable-accounts-limit.patch
              ./0005-Add-option-to-disable-stories.patch
            ];
          });
          default = telegram-desktop-patched;
        };
      }
    );
}
