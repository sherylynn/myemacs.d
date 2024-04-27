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

(when (equal my-use-package-filetree "treemacs")
  (use-package treemacs
    :defer t
    :if (equal my-use-package-filetree "treemacs")
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
	    ;;文件之间的缩进
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
	    ;;显示隐藏文件
            treemacs-show-hidden-files               t
	    ;;安静监听文件
            treemacs-silent-filewatch                nil
	    ;;安静刷新
            treemacs-silent-refresh                  nil
	    ;;排序
            treemacs-sorting                         'alphabetic-asc
            treemacs-select-when-already-in-treemacs 'move-back
            treemacs-space-between-root-nodes        t
            treemacs-tag-follow-cleanup              t
            treemacs-tag-follow-delay                1.5
            treemacs-text-scale                      nil
            treemacs-user-mode-line-format           nil
            treemacs-user-header-line-format         nil
            treemacs-wide-toggle-width               70
	    ;;窗口宽度
            treemacs-width                           20
	    ;;窗口调整宽度
            treemacs-width-increment                 1
            ;;treemacs-width-is-initially-locked       t
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
    )

  (use-package treemacs-projectile
    :after (treemacs projectile)
    )

  (use-package treemacs-icons-dired
    :hook (dired-mode . treemacs-icons-dired-enable-once)
    )

  (use-package treemacs-magit
    :after (treemacs magit)
    )

  (use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
    :after (treemacs persp-mode) ;;or perspective vs. persp-mode
    :config (treemacs-set-scope-type 'Perspectives))

  (use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
    :after (treemacs)
    :config (treemacs-set-scope-type 'Tabs))

  )

;;----------------evil--------------------
;;leader键
(when (equal my-use-package-leader "evil-leader")
  (use-package evil-leader
    :init
    ;;evil-collection 的 warning, 不得不关闭
    (setq evil-want-keybinding nil)
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "SPC")
    (evil-leader/set-key
     ;;org file
     "zo" 'open-myorg
     ;;reload init.el
     "zr" 'reload-emacs
     ;;init.el
     "ze" 'configure-emacs
     ;;neotree
     "1" 'neotree-toggle
     ;;quit buffer
     "q" 'kill-buffer-and-window
     ;;quit emacs
     "zz" 'kill-emacs ;;evil leader 不能用qq叠词
     ;;magit-status
     "gg" 'magit-status
     )
    )
  )

(when (equal my-use-package-vim "meow")
  (use-package meow
    :config
    ;;(meow-setup)
    (meow-global-mode 1)
    )
  )
