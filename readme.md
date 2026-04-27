# what is this repo
I'm experimenting with nix-on-droid apps from f-droid 
https://github.com/nix-community/nix-on-droid
I will put my main config folder here.
this config is a bit messy but atleast it's works (for now)



## some extra system config commands
(that make this repo not quite reproducible out of the box)

add home-manager
`nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --update`


add unstable nixpkgs so I can use nix-shell
`nix-channel --add https://nixos.org/channels/nixpkgs-unstable`
`nix-channel --update`

## quick start??
(I didn't try to purge then rebuild my system from zero yet so I'm not 100% sure is it works?
- install nix-on-droid
- enable flake when first start
- at nix-on-droid.nix, enable git pkgs, then use `nix-on-droid switch`
- try cd, pwd till you reach `/data/data/com.termux.nix/files/home/.config/` or `.config` then git clone this repo
- if this works, this repo will be at `/data/data/com.termux.nix/files/home/.config/nix-on-droid`
- `nix-on-droid switch --flake ~/.config/nix-on-droid`

