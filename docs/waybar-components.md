# Waybar 现有组件清单

本文档根据当前生效的 Waybar 配置整理，主要对应 `~/.config/waybar/config` 中的 `"[TOP] Default Laptop"` 布局。

## 概览

当前 Waybar 分为三部分：

- 左侧：媒体、窗口与可视化信息。
- 中间：启动器、工作区、时间和桌面状态。
- 右侧：系统托盘、网络、硬件状态、音频、电源与开关类功能。

## 左侧组件

- `custom/cava_mviz`：音频可视化器，用于显示当前声音播放的动态效果。
- `custom/playerctl`：媒体播放器控制与状态显示，可显示当前播放内容并支持播放控制。
- `hyprland/window`：当前活动窗口标题，便于快速查看正在使用的程序。

## 中间组件

- `group/app_drawer`：应用入口组，收纳常用桌面快捷操作。
  - `custom/menu`：Rofi 应用菜单入口。
  - `custom/light_dark`：切换 light / dark mode。
  - `custom/file_manager`：文件管理器入口。
  - `custom/tty`：终端入口。
  - `custom/browser`：浏览器入口。
  - `custom/settings`：Hyprland 快速设置菜单。
- `group/notify`：通知相关组。
  - `custom/swaync`：通知中心状态与开关。
  - `custom/dot_update`：配置更新提示。
- `hyprland/workspaces#rw`：工作区列表，并结合窗口 rewrite 显示应用图标。
- `clock`：系统时间与日期。
- `custom/weather`：天气信息显示，当前走 `WeatherWrap.sh`。
- `idle_inhibitor`：防止系统自动休眠的状态指示与切换。
- `custom/hint`：快捷提示与键位帮助入口。

## 右侧组件

- `tray`：系统托盘图标区域。
- `network#speed`：网络接口与上下行速度显示。
- `group/laptop`：笔记本相关状态组。
  - `backlight`：屏幕亮度。
  - `battery`：电池状态与电量。
- `group/mobo_drawer`：硬件监控组。
  - `temperature`：温度。
  - `cpu`：CPU 占用率。
  - `power-profiles-daemon`：性能模式切换，显示当前 profile。
  - `memory`：内存使用情况。
  - `disk`：磁盘占用情况。
- `group/audio`：音频控制组。
  - `pulseaudio`：输出音量。
  - `pulseaudio#microphone`：麦克风音量与静音状态。
- `custom/nightlight`：夜间模式开关，调用 `Hyprsunset` 控制屏幕色温。
- `group/status`：系统状态与电源组。
  - `custom/power`：电源菜单。
  - `custom/lock`：锁屏。
  - `keyboard-state`：Caps Lock / Num Lock 状态。
  - `custom/keyboard`：当前键盘布局与切换。

## 额外可用模块

以下模块已在配置库中定义，但未必出现在当前默认栏布局里：

- `backlight#2`
- `battery#2`
- `clock#2`
- `clock#3`
- `clock#4`
- `clock#5`
- `hyprland/language`
- `hyprland/submap`
- `power-profiles-daemon`
- `pulseaudio#1`
- `wireplumber`
- `wlr/taskbar`
- `custom/weather`
- `custom/hyprpicker`
- `custom/cycle_wall`
- `custom/power`
- `custom/reboot`
- `custom/quit`
- `custom/swaync`
- `custom/updater`
- `custom/separator#dot`
- `custom/separator#dot-line`
- `custom/separator#line`
- `custom/separator#blank`
- `custom/separator#blank_2`
- `custom/separator#blank_3`
- `custom/arrow1`
- `custom/arrow2`
- `custom/arrow3`
- `custom/arrow4`

## 相关交互

- `custom/light_dark`：左键切换 light / dark mode，右键打开 Waybar Styles 菜单，中键打开壁纸菜单。
- `custom/menu`：左键打开 Rofi 菜单，右键打开 Waybar Layout 菜单，中键打开壁纸菜单。
- `custom/cycle_wall`：左键壁纸菜单，中键随机壁纸，右键 Waybar Styles 菜单。
- `custom/swaync`：左键打开通知中心，右键切换勿扰模式。
- `custom/nightlight`：切换夜间模式色温。

## 备注

- 当前 Waybar 以 `"[TOP] Default Laptop"` 为主布局。
- 实际显示内容会受当前选择的 `Waybar Style` 和 `Waybar Layout` 影响，但组件功能定义保持不变。
