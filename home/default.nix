{ username, ... }:

{
  imports = [
    # 导入拆分后的模块
    ./modules/shell/fish.nix
    ./modules/shell/starship.nix
    ./modules/terminals/rio.nix
    ./modules/terminals/yazi.nix
    ./modules/editors/helix.nix
    ./modules/editors/zed.nix
    ./modules/browser/default.nix
    ./modules/input/fcitx5.nix
    ./modules/tools/common.nix
    ./modules/dev/default.nix
    ./modules/gaming/default.nix
    ./modules/desktop/kde.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";
}
