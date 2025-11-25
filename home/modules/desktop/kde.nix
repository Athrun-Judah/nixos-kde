{ pkgs, ... }:

{
  # 自动启动 Fcitx5 (虽然 KDE 设置里也能加，但这里声明更可靠)
  home.file.".config/autostart/org.fcitx.Fcitx5.desktop".text = ''
    [Desktop Entry]
    Name=Fcitx 5
    GenericName=Input Method
    Comment=Start Input Method
    Exec=fcitx5
    Icon=fcitx
    Terminal=false
    Type=Application
    Categories=System;Utility;
    StartupNotify=false
    X-GNOME-Autostart-Phase=Applications
    X-GNOME-AutoRestart=false
    X-GNOME-Autostart-Notify=false
    X-KDE-autostart-after=panel
  '';

  # 强制文件关联 (这是精简 KDE 的关键)
  # 确保双击文件不会去寻找被我们删掉的 KDE 软件
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.kde.okular.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/png" = [ "imv.desktop" ];
      "video/mp4" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ]; # mkv 格式
      "video/x-msvideo" = [ "vlc.desktop" ];  # avi 格式
      "video/quicktime" = [ "vlc.desktop" ];  # mov 格式
      "text/plain" = [ "Helix.desktop" ]; # 或者是 zed
      "inode/directory" = [ "org.kde.dolphin.desktop" ];
    };
  };
}
