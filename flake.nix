{
  description = "Telegram Desktop with custom patches";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
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
            ];
          });
          default = telegram-desktop-patched;
        };
      }
    );
}