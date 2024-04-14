;; 关闭开始界面 hide startup message
(setq inhibit-startup-message t)
;;打开行号
(global-display-line-numbers-mode 1)
;;相对行号
(setq display-line-numbers-type 'relative)

(add-hook
 'vterm-mode-hook
 (
  ;;当启动vterm的时候关闭行号,关闭tabs
  lambda()
  (display-line-numbers-mode 0)
  ;;没有当前窗口关闭的tab，算了
  ;;(awesome-tab-mode 0)
  ))
(add-hook
 'org-mode-hook
 (
  ;;当启动org的时候关闭行号
  lambda()
  (display-line-numbers-mode 0)
  ;;没有当前窗口关闭的tab，算了
  ;;(awesome-tab-mode 0)
  ))
;;better-defaults 比如关闭工具栏等有趣的行为
;;(use-package better-defaults)
;;手动控制上述行为
(when (display-graphic-p)
  (menu-bar-mode -1) ;;关闭菜单栏
  (scroll-bar-mode -1) ;;关闭滚动栏
  (tool-bar-mode -1) ;;取消工具栏
  )
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
(when (equal my-use-package-filetree "neotree")
  (use-package neotree
    ;;需要 all the icon 包
    :config
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
  )
(when (equal my-use-package-filetree "treemacs")
  (use-package treemacs
    :defer t
    :init
    (with-eval-after-load 'winum
      (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
    :config
    (progn
      (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
            treemacs-deferred-git-apply-delay        0.5
            treemacs-directory-name-transformer      #'identity
            treemacs-display-in-side-window          t
            treemacs-eldoc-display                   'simple
            treemacs-file-event-delay                2000
            treemacs-file-extension-regex            treemacs-last-period-regex-value
            treemacs-file-follow-delay               0.2
            treemacs-file-name-transformer           #'identity
            treemacs-follow-after-init               t
            treemacs-expand-after-init               t
            treemacs-find-workspace-method           'find-for-file-or-pick-first
            treemacs-git-command-pipe                ""
            treemacs-goto-tag-strategy               'refetch-index
            treemacs-header-scroll-indicators        '(nil . "^^^^^^")
            treemacs-hide-dot-git-directory          t
            treemacs-indentation                     2
            treemacs-indentation-string              " "
            treemacs-is-never-other-window           nil
            treemacs-max-git-entries                 5000
            treemacs-missing-project-action          'ask
            treemacs-move-forward-on-expand          nil
            treemacs-no-png-images                   nil
            treemacs-no-delete-other-windows         t
            treemacs-project-follow-cleanup          nil
            treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
            treemacs-position                        'left
            treemacs-read-string-input               'from-child-frame
            treemacs-recenter-distance               0.1
            treemacs-recenter-after-file-follow      nil
            treemacs-recenter-after-tag-follow       nil
            treemacs-recenter-after-project-jump     'always
            treemacs-recenter-after-project-expand   'on-distance
            treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
            treemacs-project-follow-into-home        nil
            treemacs-show-cursor                     nil
            treemacs-show-hidden-files               t
            treemacs-silent-filewatch                nil
            treemacs-silent-refresh                  nil
            treemacs-sorting                         'alphabetic-asc
            treemacs-select-when-already-in-treemacs 'move-back
            treemacs-space-between-root-nodes        t
            treemacs-tag-follow-cleanup              t
            treemacs-tag-follow-delay                1.5
            treemacs-text-scale                      nil
            treemacs-user-mode-line-format           nil
            treemacs-user-header-line-format         nil
            treemacs-wide-toggle-width               70
            treemacs-width                           35
            treemacs-width-increment                 1
            treemacs-width-is-initially-locked       t
            treemacs-workspace-switch-cleanup        nil)

      ;; The default width and height of the icons is 22 pixels. If you are
      ;; using a Hi-DPI display, uncomment this to double the icon size.
      ;;(treemacs-resize-icons 44)

      (treemacs-follow-mode t)
      (treemacs-filewatch-mode t)
      (treemacs-fringe-indicator-mode 'always)
      (when treemacs-python-executable
	(treemacs-git-commit-diff-mode t))

      (pcase (cons (not (null (executable-find "git")))
                   (not (null treemacs-python-executable)))
	(`(t . t)
	 (treemacs-git-mode 'deferred))
	(`(t . _)
	 (treemacs-git-mode 'simple)))

      (treemacs-hide-gitignored-files-mode nil))
    :bind
    (:map global-map
          ("M-0"       . treemacs-select-window)
          ("C-x t 1"   . treemacs-delete-other-windows)
          ("C-x t t"   . treemacs)
          ("C-x t d"   . treemacs-select-directory)
          ("C-x t B"   . treemacs-bookmark)
          ("C-x t C-t" . treemacs-find-file)
          ("C-x t M-t" . treemacs-find-tag)))

  (use-package treemacs-evil
    :after (treemacs evil)
    :ensure t)

  ;;(use-package treemacs-projectile
  ;;:after (treemacs projectile)
  ;;:ensure t)

  (use-package treemacs-icons-dired
    :hook (dired-mode . treemacs-icons-dired-enable-once)
    :ensure t)

  (use-package treemacs-magit
    :after (treemacs magit)
    :ensure t)

  (use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
    :after (treemacs persp-mode) ;;or perspective vs. persp-mode
    :ensure t
    :config (treemacs-set-scope-type 'Perspectives))

  (use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
    :after (treemacs)
    :ensure t
    :config (treemacs-set-scope-type 'Tabs))

  )
;;熟悉的tab栏
(unless (equal my-use-package-tab-bar "awesome-tab" )
  (use-package tab-bar
    :custom
    (tab-bar-separator "")
    (tab-bar-new-tab-to 'rightmost)
    (tab-bar-show 1)
    (tab-bar-close-button-show t)
    (tab-bar-new-tab-choice "*scratch*")
    (tab-bar-tab-hints t)
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
(unless (equal my-use-package-tab-bar "tab-bar" )
  ;;awesome-tab ;;gui下面激活的不明显，试试官方包
  (when (< emacs-major-version 30)
    (use-package awesome-tab
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
    )
  )
;;elisp ()括号🌈彩虹
(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

;;全局字体大小调整
;;(use-package default-text-scale)
;;也能实现全局大小调整
;;中文英文等宽
(when (display-graphic-p)
  (use-package cnfonts
    :config
    (cnfonts-mode 1)
    ;;使用这个会给中文和英文分配不一样的字号，用起来有点离谱
    )
  )
(provide 'init-ui)
