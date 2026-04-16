# Coding Conventions

## Desktop Configuration

- 在 CachyOS + Hyprland 环境中，先验证已安装包实际提供的命令名，再把它写进启动项；不要默认 `swww` 一定可用，`awww` 这类替代实现可能使用不同的二进制名称。
- 壁纸、输入法、缩放这类用户态体验项，优先通过会话启动项持续恢复，不要只依赖一次性初始化脚本。
- 高 DPI 终端和桌面可读性问题，应同时检查 `monitors.conf` 的缩放和 GTK / Qt 的环境变量，而不是只改字体大小。
- SDDM 登录页的字号和控件大小应优先局部调整对应 QML 组件，不要为了放大表单而改动会把时间日期一起放大的全局字体配置。
- 桌面壁纸和登录页壁纸应分开入口管理：桌面继续走会话内壁纸后端，登录页则通过独立的 SDDM 同步脚本处理。
- QuickShell overview 必须同时满足两件事：`quickshell` 包已安装，且 `~/.config/quickshell` 里存在完整的 `overview` 配置树；只复制部分文件不足以让 `super + a` 稳定工作。
- Waybar 主题切换应保留一个已知可用的安全主题，并在刷新链路里准备自动回退，避免坏主题把 bar 直接弄消失。
- Waybar 的“主题切换”“style 切换”和“布局切换”是三条不同路径：`ThemeChanger.sh` 负责全局 `wallust` 主题，`DarkLight.sh` 负责模式联动但不应再自动改 `Waybar` style，`WaybarStyles.sh` 负责显式 style 切换，`WaybarLayout.sh` 负责布局切换，不要把 style 变化误判为主题刷新生效。

## Input Method

- Wayland 桌面下优先使用 `fcitx5` 体系，并通过 Hyprland 环境变量统一接入 GTK、Qt、XMODIFIERS 和 SDL。
- 如果安装预设要开箱提供中文输入，包清单必须同时覆盖 `fcitx5` 核心、`fcitx5-chinese-addons`、图形配置工具，以及 GTK / Qt 桥接包；只补运行时环境变量，首次进入桌面时仍可能没有可用输入法。
- 如果用户要的是“拼音键盘输入、繁体输出”，优先考虑 `fcitx5-rime`；`fcitx5-chewing` 是新酷音/注音路线，不要把它当成拼音繁体方案。
- 新增输入法时应保留现有 `DefaultIM`，只在 `fcitx5` profile 里追加可切换项，避免把默认输入法误改掉。
- 图形化管理入口应尽量复用现有桌面样式；如果脚本不可执行，优先通过 `bash` 包装调用，而不是强行改权限流程。

## Shell UX

- `fish` 和 `zsh` 的联想提示是两套独立配置，应分别在各自配置文件中调整。
- 联想提示默认通常偏暗，若需要更高可见性，应直接覆盖 shell 自带的 autosuggestion 颜色配置。
