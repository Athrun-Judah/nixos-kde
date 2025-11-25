{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    # Stylix 会自动配置 Gruvbox 主题
  };
}
