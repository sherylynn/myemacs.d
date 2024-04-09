;; 关闭开始界面 hide startup message
(setq inhibit-startup-message t)
;;打开行号
(global-display-line-numbers-mode 1)
;;相对行号
(setq display-line-numbers-type 'relative)
;;better-defaults 比如关闭工具栏等有趣的行为
;;(use-package better-defaults)
;;手动控制上述行为
(menu-bar-mode -1) ;;关闭菜单栏
(scroll-bar-mode -1) ;;关闭滚动栏
(tool-bar-mode -1) ;;取消工具栏
;;自动换行
(auto-fill-mode 1)
;;高亮当前行
(global-hl-line-mode 1)
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
  (doom-themes-neotree-config)
  ;; or for treemacs users
  ;;(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;;(doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
;;偷用 doom 的状态栏
(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-project-detection 'project))
;;直接用 doom 的 dashboard
(when (equal my-init-config-timeup "debug")
  (use-package dashboard
    :config
    (progn
      (dashboard-setup-startup-hook)))
  )
;;熟悉的文件栏
(use-package neotree
  ;;需要 all the icon 包
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
;;熟悉的tab栏
(when (< emacs-major-version 30)
  (use-package awesome-tab
    :quelpa (awesome-tab :fetcher github :repo "manateelazycat/awesome-tab")
    :config
    (awesome-tab-mode t)
    )
  )

;;elisp ()括号🌈彩虹
(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

;;字体调整
(use-package default-text-scale)

(provide 'init-ui)
