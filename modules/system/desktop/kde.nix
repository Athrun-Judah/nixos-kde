{ pkgs, ... }:

{
  # 1. 显示管理器 (SDDM)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    # 主题将由 Stylix 自动管理
  };

  # 2. KDE Plasma 6 桌面
  services.desktopManager.plasma6.enable = true;
  stylix.targets.kde.enable = true;

  # 3. 强力去肥大化 (Debloat)
  # 这是一个“黑名单”，禁止安装以下 KDE 全家桶软件
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # --- 媒体与娱乐 ---
    elisa           # 音乐播放器 (你用 mpv/foliate)
    gwenview        # 图片查看器 (你用 imv)
    dragon          # 视频播放器
    khelpcenter     # 帮助中心

    # --- 办公与工具 ---
    kate            # 同上
    print-manager   # 打印机管理 (如果不打印可以去掉)

    # --- 终端 ---
    konsole         # 终端 (你用 rio)

    # --- PIM 套件 (个人信息管理 - 最臃肿的部分) ---
    kmail           # 邮件客户端
    kaddressbook    # 通讯录
    kontact         # 整合套件
  ];

  # 4. 必要的门户与服务
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # 改善非 KDE 应用的对话框兼容性
  };

  # 启用 KDE 钱包 (保存 WiFi 密码等)
  security.pam.services.sddm.enableKwallet = true;
  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  # 确保 Qt 应用使用 Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  # 安装必要的系统工具 (为了填补精简后的空白)
  environment.systemPackages = with pkgs; [
    wl-clipboard   # Wayland 剪贴板工具
    kdePackages.ark # 压缩包管理器 (KDE 原生，集成度高，建议保留)
    kdePackages.spectacle # 截图工具 (KDE 原生最好用，支持标注)
    kdePackages.partitionmanager # 分区管理
  ];
}
