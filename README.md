### Telegram desktop flake with patches from https://github.com/Layerex/telegram-desktop-patches for Nix(OS)

### To install, add this to your flake:

```nix
inputs = {
  telegram-desktop-patched.url = "github:shwewo/telegram-desktop-patched";
  # .. your other flakes
};
```

To use my binary cache, add this to nix config:

```nix
nix = {
  settings = {
    substituters = [
      "https://shwewo.cachix.org"
    ];
    trusted-public-keys = [
      "shwewo.cachix.org-1:84cIX7ETlqQwAWHBnd51cD4BeUVXCyGbFdtp+vLxKOo="
    ];
    # other options...
  };
};
```

To use it in your system (home manager/nixos) add this to your configuration.nix: 

```nix
environment.systemPackages = with pkgs; [
  inputs.telegram-desktop-patched.packages.${pkgs.system}.default
];
```

or for home-manager

```nix
home.packages = with pkgs; [
  inputs.telegram-desktop-patched.packages.${pkgs.system}.default
];
```

Don't forget to include inputs if you use home manager:

```nix
home-manager.extraSpecialArgs = { 
  inherit inputs;
};
```

You can look up in my dotfiles for info: https://github.com/shwewo/dotfiles
