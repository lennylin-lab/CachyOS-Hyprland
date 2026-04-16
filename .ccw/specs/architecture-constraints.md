# Architecture Constraints

## Runtime Constraints

- 用户会话中的桌面效果必须以实际已安装组件为准，不能假设上游文档里的命令名或包名与本机一致。
- Hyprland 相关的会话级修改需要重新登录或重启后才能完整生效，不能把当前 shell 会话的环境变量当作系统最终状态。
- 修改 SDDM 主题的颜色、表单尺寸或背景图片时，要考虑主题目录位于 `/usr/share/sddm/themes/...` 这一受保护路径，脚本应优先尝试 `sudo -n`，再按需回退到显式提权流程。
- `super + a` 的 overview 路径不能只依赖脚本判断，必须同时验证 `quickshell` 可执行文件、运行中的 `qs` 服务，以及 `~/.config/quickshell/overview` 配置是否完整。
- Waybar 主题刷新链路必须假设个别 CSS 文件会加载失败，因此 `Refresh.sh` 需要保留一个安全回退主题，而不是默认把桌面留在空 bar 状态。
- 不要把 Waybar 的 style 切换、布局切换和主题切换混为一谈；`ThemeChanger.sh` 负责全局 `wallust` 主题，`DarkLight.sh` 负责模式联动但不应自动改 `Waybar` style，`WaybarStyles.sh` 负责显式 style 切换，`WaybarLayout.sh` 负责布局切换，它们的用户感知效果可能相似但职责不同。

## Localization Constraints

- 系统语言与地区设置应通过 `localectl` 或等效系统级机制统一管理，避免同时保留多套相互冲突的环境定义。
- 语言、地区、输入法三者要一起检查：仅改 `LANG` 通常不足以保证中文输入和中文格式都正常。

## UX Constraints

- 壁纸恢复逻辑必须在会话启动时执行，不能仅在首次安装或一次性初始化阶段运行。
- 对终端联想提示的视觉调整，应避免改动提示逻辑本身，只覆盖颜色与高亮样式。
