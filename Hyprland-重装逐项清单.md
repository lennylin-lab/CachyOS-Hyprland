# Hyprland 重装逐项清单

这份清单面向当前这台机器的目标方案：`CachyOS/Arch 最小系统 + JaKooLit Arch-Hyprland + Intel 显卡 + SDDM + PipeWire`。

## 外部准备

- `8GB` 以上 U 盘一个
- 最新 `CachyOS ISO`
- 可用于写启动盘的另一台设备或当前系统
- 稳定网络
- 备份介质：移动硬盘、NAS 或网盘
- LiveUSB 保留到安装完成后，不要中途格式化

## 重装前

1. 备份个人数据
   - `~/Documents`
   - `~/Pictures`
   - 项目目录
   - SSH keys
   - GPG keys
   - 浏览器配置
   - VPN 配置
   - 输入法词库
2. 导出当前包列表

```bash
pacman -Qqe > ~/pkglist-before-reinstall.txt
```

3. 创建一次 `snapper` 快照
4. 确认 `projects/Arch-Hyprland` 已备份或记住远端地址

## 制作启动盘

1. 下载 `CachyOS ISO`
2. 使用 Rufus、balenaEtcher、Ventoy 或其他工具写入 U 盘
3. 重启并从 U 盘启动

## 安装新系统

1. 进入安装环境
2. 连上网络
3. 选择最小安装路线，不先装完整桌面
4. 根分区优先继续使用 `btrfs`
5. 确认安装内容至少包括：
   - 普通用户
   - `sudo`
   - 网络
   - 基础系统
6. 完成安装并重启进入新系统

## 新系统首次启动后

1. 进入 TTY 或最简环境
2. 安装基础依赖

```bash
sudo pacman -S --needed git base-devel snapper
```

3. 如果需要继续用回滚，配置好 `snapper`
4. 拉取仓库

```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/JaKooLit/Arch-Hyprland
cd Arch-Hyprland
chmod +x tools/run-cachyos-intel-install.sh tools/verify-cachyos-hyprland.sh
```

## 安装 Hyprland

必须从 TTY 执行，不要从现有桌面会话里跑。

```bash
cd ~/projects/Arch-Hyprland
./tools/run-cachyos-intel-install.sh
```

安装时保持这些选择：

- AUR helper 选 `paru`
- `dots` 保持开启
- `SDDM` 保持开启
- `SDDM theme` 保持开启
- `Bluetooth` 保持开启
- `Thunar` 保持开启
- `XDG Desktop Portal Hyprland` 保持开启
- `NVIDIA` 相关全部关闭
- `ROG` 关闭
- `zsh` 暂时关闭

## 首次进入 Hyprland 后

1. 重启
2. 在 `SDDM` 里选择 `Hyprland`
3. 登录后打开终端执行

```bash
~/projects/Arch-Hyprland/tools/verify-cachyos-hyprland.sh
```

## 手动验收

逐项确认：

1. 分辨率、缩放、多屏正常
2. 音频播放正常
3. 麦克风输入正常
4. 蓝牙可开启并能搜索设备
5. Waybar 正常显示
6. 通知正常
7. 截图正常
8. 剪贴板正常
9. 锁屏与解锁正常
10. 浏览器或会议软件屏幕共享正常
11. 休眠与唤醒正常
12. 亮度键和音量键正常

## 出问题时先看哪里

1. `~/projects/Arch-Hyprland/Install-Logs/`
2. 用户服务状态

```bash
systemctl --user status pipewire wireplumber
```

3. `SDDM` 状态

```bash
systemctl status sddm
```

4. 如果进不去图形界面，先回 TTY 修复
5. 如果系统层面损坏，再用 LiveUSB + `snapper` 或 `chroot` 处理
