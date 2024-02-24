{
  description = "Telegram Desktop with custom patches";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

  outputs = inputs @ { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = inputs.nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          telegram-desktop-patched = pkgs.telegram-desktop.overrideAttrs (oldAttrs: {
            patches = oldAttrs.patches ++ [
              (pkgs.fetchpatch {
                url = "https://raw.githubusercontent.com/Layerex/telegram-desktop-patches/master/0001-Disable-sponsored-messages.patch";
                hash = "sha256-o2Wxyag6hpEDgGm8FU4vs6aCpL9aekazKiNeZPLI9po=";
              })
              (pkgs.fetchpatch {
                url = "https://raw.githubusercontent.com/Layerex/telegram-desktop-patches/master/0002-Disable-saving-restrictions.patch";
                hash = "sha256-sQsyXlvhXSvouPgzYSiRB8ieICo3GDXWH5MaZtBjtqw=";
              })
              (pkgs.fetchpatch {
                url = "https://raw.githubusercontent.com/Layerex/telegram-desktop-patches/master/0003-Disable-invite-peeking-restrictions.patch";
                hash = "sha256-8mJD6LOjz11yfAdY4QPK/AUz9o5W3XdupXxy7kRrbC8="; 
              })
              (pkgs.fetchpatch {
                url = "https://raw.githubusercontent.com/Layerex/telegram-desktop-patches/master/0004-Disable-accounts-limit.patch";
                hash = "sha256-PZWCFdGE/TTJ1auG1JXNpnTUko2rCWla6dYKaQNzreg=";
              })
              (pkgs.fetchpatch {
                url = "https://raw.githubusercontent.com/Layerex/telegram-desktop-patches/3f45a43ef59b5706bfe71f9fcdea371894904c13/0005-Add-option-to-disable-stories.patch";
                hash = "sha256-b0Oy15Ppp1dHrTfoq+AGwICIeoQS1F0+ZqGbbfaitHk=";
              })
            ];
          });
          default = telegram-desktop-patched;
        };
      }
    );
}
