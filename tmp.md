已经做了什么

  - 把 QuickShell 的工作区切换栏改成了 1×5 横向 popup carousel。
  - 让它支持 首尾 wrap，可以无限循环切换，不会卡边界。
  - 给空工作区加了 壁纸缩略图背景。
  - 把空工作区的壁纸来源稳定到 ~/.cache/quickshell/wallpaper_thumbnail.png，并在 WallustSwww.sh 里同步生成。
  - 确认真正生效的配置文件是：
      - /home/lenny/.config/quickshell/overview/common/Appearance.qml
      - /home/lenny/.config/quickshell/overview/common/Config.qml
      - /home/lenny/.config/quickshell/overview/modules/overview/OverviewWidget.qml
  - 去掉了非空工作区的模糊蒙层，只保留空卡片的暗层。
  - 给切换加了更顺滑的动画。
  - 会话记录已经同步到了 project-tech.json。

  后续如果要调，主要看这几个位置

  1. 整体宽度 / 间距

  - 文件：
      - /home/lenny/.config/quickshell/overview/common/Config.qml
  - 主要参数：
      - carouselViewportSpan
      - carouselStepFactor
  - 作用：
      - carouselViewportSpan 控制整个 popup 有多宽。
      - carouselStepFactor 控制卡片之间的横向间距。

  2. 中心和边缘卡片大小差距

  - 文件：
      - /home/lenny/.config/quickshell/overview/modules/overview/OverviewWidget.qml
  - 主要位置：
      - slotScale(distance)
      - width: ...
      - height: ...
  - 作用：
      - 这里决定中心卡片和两侧卡片的大小差异。
      - 想让中心更突出、边缘更小，就改这里。

  3. 空工作区壁纸缩略图

  - 文件：
      - /home/lenny/.config/quickshell/overview/modules/overview/OverviewWidget.qml
  - 主要位置：
      - wallpaperThumbnail
      - wallpaperContainer
      - Rectangle 暗层
  - 作用：
      - 控制空卡片壁纸显示、暗罩强度、缩略图裁切方式。

  4. 工作区数字大小和可见性

  - 文件：
      - /home/lenny/.config/quickshell/overview/modules/overview/OverviewWidget.qml
  - 主要位置：
      - StyledText { text: workspaceValue ... }
  - 作用：
      - 控制数字大小、颜色、透明度。
      - 如果觉得数字还不够醒目，就改这里。

  5. 动画速度和过渡手感

  - 文件：
      - /home/lenny/.config/quickshell/overview/common/Config.qml
  - 主要参数：
      - carouselAnimationDuration
  - 文件：
      - /home/lenny/.config/quickshell/overview/modules/overview/OverviewWidget.qml
  - 主要位置：
      - Behavior on x / y / scale / opacity
  - 作用：
      - 控制切换是不是更丝滑、动画更快还是更慢。

  6. 空卡片暗层和边缘露出感

  - 文件：
      - /home/lenny/.config/quickshell/overview/modules/overview/OverviewWidget.qml
  - 主要位置：
      - ghostWorkspaceColor
      - 空卡片的 Rectangle 暗层
  - 作用：
      - 控制空卡片到底有多暗。
      - 控制边缘卡片“露出多少”。

  最常用的调参入口
  如果你后面只想快速微调，我建议优先看这 3 个地方：

  - /home/lenny/.config/quickshell/overview/common/Config.qml
      - 调整体宽度、间距、动画速度
  - /home/lenny/.config/quickshell/overview/modules/overview/OverviewWidget.qml
      - 调大小差距、数字、暗层、空卡片壁纸
  - /home/lenny/.config/hypr/scripts/WallustSwww.sh
      - 调壁纸缓存来源，如果以后壁纸源链路还想换
