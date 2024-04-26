;; 关闭开始界面 hide startup message
(setq inhibit-startup-message t)
;;打开行号
(global-display-line-numbers-mode 1)
;;相对行号
(setq display-line-numbers-type 'relative)

(add-hook
 'vterm-mode-hook
 (
  ;;当启动 vterm 的时候关闭行号,关闭 tabs
  lambda()
  (display-line-numbers-mode 0)
  ;;没有当前窗口关闭的 tab，算了
  ;;(awesome-tab-mode 0)
  ))
(add-hook
 'org-mode-hook
 (
  ;;当启动 org 的时候关闭行号
  lambda()
  (display-line-numbers-mode 0)

  ;;打开 buffer 大小
  (size-indication-mode)
  ;;没有当前窗口关闭的 tab，算了
  ;;(awesome-tab-mode 0)

  ;;开启 org 下面自动换行
  (setq truncate-lines nil)

  ))
;;better-defaults 比如关闭工具栏等有趣的行为
;;(use-package better-defaults)
;;手动控制上述行为

(when (display-graphic-p)
  (scroll-bar-mode -1) ;;关闭滚动栏
  (tool-bar-mode -1) ;;取消工具栏
  )
(menu-bar-mode -1) ;;关闭菜单栏
;;自动换行
(auto-fill-mode 1)

;;高亮当前行
(global-hl-line-mode 1)
;;改变一下高亮覆盖的效果，免得影响当前行的颜色大变
;;(custom-set-faces '(hl-line ((t (:background "#DCFFFA"))))) ;;难调

;;关闭烦人的 warning,和我有毛线关系？
(setq warning-minimum-level :error)

;;偷用 doom 的主题
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dark+ t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;;(doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
;;偷用 doom 的状态栏
(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :custom
  ;;显示时间
  (doom-modeline-time t)
  ;;显示电量
  (doom-modeline-battery t)
  :config
  (setq doom-modeline-project-detection 'project)
  )
;;直接用 doom 的 dashboard
(when (equal my-init-config-timeup "normal")
  (use-package dashboard
    :config
    (progn
      (dashboard-setup-startup-hook)))
  )
;;熟悉的 tab 栏
(when (equal my-use-package-tab-bar t)
  ;;(unless (equal my-use-package-tab-bar "awesome-tab" )
  (use-package tab-bar
    :custom
    (tab-bar-separator "|")
    (tab-bar-new-tab-to 'rightmost) ;;open tabs in right
    (tab-bar-show 1) ;;hide bar if <= 1 tabs open
    (tab-bar-auto-width nil) ;;自动宽度取消
    (tab-bar-close-button-show t) ;;显示关闭按钮
    (tab-bar-new-tab-choice "*scratch*") ;;新tab的buffer
    (tab-bar-tab-hints t) ;;显示tab-bar 序号
    ;;(tab-bar-format '(tab-bar-format-menu-bar tab-bar-format-tabs tab-bar-separator))
    (tab-bar-format '(tab-bar-format-tabs tab-bar-separator))
    :config
    (tab-bar-mode 1)
    )
  (defun my-prev-tab()
    (interactive)
    (tab-bar-switch-to-prev-tab)
    )
  (defun my-next-tab()
    (interactive)
    (tab-bar-switch-to-next-tab)
    )
  )
(when (equal my-use-package-awesome-tab t)
  ;;(unless (equal my-use-package-tab-bar "tab-bar" )
  ;;awesome-tab ;;gui 下面激活的不明显，试试官方包
  ;;(when (< emacs-major-version 30)
  (use-package awesome-tab
    ;;:unless (equal my-use-package-awesome-tab t)
    :quelpa (awesome-tab :fetcher github :repo "manateelazycat/awesome-tab")
    :custom
    ;;搞了个紫色激活背景的标签栏
    (awesome-tab-dark-active-bar-color "#5300f6")
    ;;搞了标签栏字体颜色
    (awesome-tab-dark-selected-foreground-color "#A3E4D7") ;;宝石绿色
    (awesome-tab-dark-unselected-foreground-color "#ABB2B9") ;;灰色
    :config
    (awesome-tab-mode t)
    ;;适配一下黑色主题
    (setq frame-background-mode 'dark)
    ;;搞了个紫色背景的标签栏
    (setq awesome-tab-terminal-dark-select-background-color "#5300f6")
    ;;搞了白色的标签栏字体
    (setq awesome-tab-terminal-dark-select-foreground-color "#ffffff")
    )
  (defun my-left-tab()
    (interactive)
    (awesome-tab-backward-tab )
    )
  (defun my-right-tab()
    (interactive)
    (awesome-tab-forward-tab )
    )
  ;;)
  )
(when (equal my-use-package-centaur-tabs t)
  (use-package centaur-tabs
    :demand
    :config
    (centaur-tabs-mode t)
    )
  )
;;elisp ()括号🌈彩虹
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  )

;;elisp 直接显示字符串 color code🌈彩虹
(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode)
  )

;;全局字体大小调整
;;(use-package default-text-scale)
;;也能实现全局大小调整
;;中文英文等宽
(when (display-graphic-p)
  (use-package cnfonts
    :config
    ;;(cnfonts-mode 1)
    ;;使用这个会给中文和英文分配不一样的字号，用起来有点离谱
    )
  )

(use-package pangu-spacing
  :hook
  ;;别改我的普通的编程文件，避免搞坏我的字符串
  (org-mode-hook . '(setq pangu-spacing-real-insert-separtor t))
  :init
  (global-pangu-spacing-mode 1)
  )
(provide 'init-ui)
