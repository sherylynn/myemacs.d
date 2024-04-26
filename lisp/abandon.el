;;----------------UI--------------------
;;直接用 doom 的 dashboard
(when (equal my-init-config-timeup "normal")
  (use-package dashboard
    :config
    (progn
      (dashboard-setup-startup-hook)))
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
