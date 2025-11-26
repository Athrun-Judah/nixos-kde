{ pkgs, host, username, ... }:

{

  nix.settings.substituters = [
    "https://cache.nixos.org/"
    "https://chaotic-nyx.nixos.community"
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "chaotic-nyx.nixos.community-1:O2pES2AC3fmSLX3jpmYpkyS2l2tVn21/3lY5cO51B40="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = host;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Indiana/Indianapolis";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" ];

  # Btrfs 优化
  fileSystems."/".options = [ "compress=zstd" "noatime" ];

  # Nix 设置
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.max-jobs = 4;
  nix.settings.cores = 8;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # 用户定义
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "gamemode" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  # 系统必备包
  environment.systemPackages = with pkgs; [
    git vim wget curl btop helix
  ];
}
