;;----------------gc启动优化--------------------
;;来自 purcell 的性能优化
;; Adjust garbage collection threshold for early startup (see use of gcmh below)
(setq gc-cons-threshold (* 128 1024 1024))
;; Process performance tuning
(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)
;; General performance tuning
(setq jit-lock-defer-time 0)

;;使用 GC 优化包
(use-package gcmh
  :config
  (gcmh-mode 1)
  )
;;为了更好的测试一下启动时间
(when (equal my-init-config-timeup "debug")
  (use-package benchmark-init
    :config
    (add-hook 'after-init-hook 'benchmark-init/deactivate)
    )
  )
;;----------------UI--------------------
;;better-defaults 比如关闭工具栏等有趣的行为
;;(use-package better-defaults)
;;手动控制上述行为

;;doom启动项目
(use-package dashboard
  :config
  (progn
    (dashboard-setup-startup-hook)))

;;中文表格美化
;;设置对字体后就不想用这个对其了，太卡了
(when (equal my-use-package-cn "valign")
  (use-package valign
    :hook
    (org-mode . valign-mode)
    )
  )

;;偷用群友主题，失败
(when (equal my-use-theme "nasy-light")
  (use-package nasy-theme
    :quelpa (nasy-theme :fetcher github :repo "nasyxx/emacs-nasy-theme")
    ;;:custom
    ;;(nasy-theme-light/dark 'light)
    (nasy-theme-light/dark 'dark)
    :config
    (load-theme 'nasy t)
    )
  )

;;(use-package crazy
;; :quelpa (crazy :fetcher github :repo "eval-exec/crazy-theme.el")
;; :ensure t)

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

;;----------------org--------------------
;;org-bars 这个包只能在图形下进行
(when (display-graphic-p)
  (when (eq my-use-package-org-bars t)
    (use-package org-bars
      :quelpa (org-bars :fetcher github :repo "tonyaldon/org-bars")
      :config
      (add-hook 'org-mode-hook #'org-bars-mode)
      )
    )
  )

;;换一个包试试, 这个包写的不好
;;太丑了这个包,终端下效果不好，表格竖线太粗
(when (eq my-use-package-org-visual-outline t)
  (use-package org-visual-outline
    :quelpa (org-visual-outline :fetcher github :repo "legalnonsense/org-visual-outline")
    :config
    (org-dynamic-bullets-mode)
    (org-visual-indent-mode)
    )
  )
(when (eq use-my-package-org-dynamic-bullets t)
  (use-package org-dynamic-bullets
    :quelpa (org-dynamic-bullets :fetcher url :url "https://github.com/legalnonsense/org-visual-outline/raw/master/org-dynamic-bullets.el")
    :config
    (org-dynamic-bullets-mode)
    )
  (use-package org-visual-indent
    :quelpa (org-visual-indent :fetcher url :url "https://github.com/legalnonsense/org-visual-outline/raw/master/org-visual-indent.el")
    :config
    (org-visual-indent-mode)
    )
  )


;;org-modern也不想用了，换其他简单的包，性能很重要。
;;还有一个问题是导致termux emacs和 native emacs不通用
;;用一个写了corfu的作者的包
;;可以终端下进行渲染，但是没有缩进对齐
;;终端下面还是丑陋的竖线，实在是太粗了
(use-package org-modern
  :after org
  :custom
  ;;把竖线弄最小了
  (org-modern-table-vertical 1)
  ;;是否覆盖默认todoword颜色
  ;;(org-modern-todo nil) ;;定制化死活不生效，直接关了
  ;;定制化todo字样并未生效
  (org-modern-todo-faces
   '(
     ("TODO" :background "blue" :foreground "green")
     ("KILL" :background "red" :foreground "yellow")
     ("WAIT" :background "#3498D8" :foreground "#ffc500")
     ("DONE" :background "black" :foreground "white")
     ))
  ;; Org modern settings
  ;; android native
  ;;(org-modern-priority nil)
  (org-modern-star nil)
  (org-modern-progress nil)
  ;;(org-modern-list nil)
  ;;(org-modern-checkbox nil)
  ;;(org-modern-todo nil)
  ;;(org-modern-keyword nil)

  ;; Editor settings
  ;;(org-auto-align-tags nil)
  ;;(org-tags-column 0)
  ;;(org-catch-invisible-edits 'show-and-error)
  ;;(org-special-ctrl-a/e t)
  :config
  (global-org-modern-mode 1)
  )
;;解决上述包的缩进问题
(use-package org-modern-indent
  :after org-modern
  :custom
  (org-startup-indented t)
  :quelpa  (org-modern-indent :fetcher github :repo "jdtsmith/org-modern-indent")
  :config ; add late to hook
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

;;简单的把org前面弄漂亮
(use-package org-superstar
  ;;:defer t
  :hook (org-mode . org-superstar-mode)
  ;;:custom
  ;;()
  :config
  ;;(org-superstar-configure-like-org-bullets)

  ;; This is usually the default, but keep in mind it must be nil
  ;;这个是原本emacs自带的让每行只显示一个星号
  (setq org-hide-leading-stars nil)
  ;; This line is necessary.
  (setq org-superstar-leading-bullet ?\s)

  ;;我不用org-indent所以不知道什么效果
  ;; If you use Org Indent you also need to add this, otherwise the
  ;; above has no effect while Indent is enabled.
  (setq org-indent-mode-turns-on-hiding-stars nil)
  ;;删掉星星的空白
  ;;(setq org-superstar-remove-leading-stars t)
  )
;;----------------program--------------------
;;自动括号
(use-package awesome-pair
  :quelpa (awesome-pair :fetcher github :repo "manateelazycat/awesome-pair")
  :hook (
         (java-mode . awesome-pair-mode)
         (js-mode . awesome-pair-mode)
         (emacs-lisp-mode . awesome-pair-mode)
         (python-mode . awesome-pair-mode)
         (go-mode . awesome-pair-mode)
         (lua-mode . awesome-pair-mode)
         (lisp-mode . awesome-pair-mode)
	 )
  :bind (
	 :map awesome-pair-mode-map
	 ("(" . awesome-pair-open-round)
	 ("[" . awesome-pair-open-bracket)
	 ("{" . awesome-pair-open-curly)
	 (")" . awesome-pair-close-round)
	 ("]" . awesome-pair-close-bracket)
	 ("}" . awesome-pair-close-curly)
	 ("=" . awesome-pair-equal)
	 )
  )
;;------------------init-utils-------------------------

;;把cnfonts绑滚轮上
(defun my-cnfonts-mouse-wheel-text-scale (event)
  "Adjust font size of the default face according to EVENT.
See also `text-scale-adjust'."
  (interactive (list last-input-event))
  (let ((selected-window (selected-window))
        (scroll-window (mouse-wheel--get-scroll-window event))
        (button (mwheel-event-button event)))
    (select-window scroll-window 'mark-for-redisplay)
    (unwind-protect
        (cond ((memq button (list mouse-wheel-down-event
                                  mouse-wheel-down-alternate-event))
	       (cnfonts-increase-fontsize)
	       ;;替换成cnfonts
	       ;;(text-scale-increase 1)
	       )
	      ((memq button (list mouse-wheel-up-event
                                  mouse-wheel-up-alternate-event))
	       ;;(text-scale-decrease 1)
	       ;;替换成cnfonts
	       (cnfonts-decrease-fontsize)
	       ))
      (select-window selected-window))))
;;其实这俩函数很像
;;(defun text-scale-increase (inc)
;;(defun touch-screen-pinch (event)

(defun my-touch-screen-pinch (event)
  "Scroll the window in the touchscreen-pinch event EVENT.
Pan the display by the pan deltas in EVENT, and adjust the
text scale by the ratio therein."
  (interactive "e")
  (require 'face-remap)
  (let* ((posn (cadr event))
         (window (posn-window posn))
         (scale (nth 2 event))
         (ratio-diff (nth 5 event))
         current-scale start-scale)
    (when (windowp window)
      (with-selected-window window
        (setq current-scale (if text-scale-mode
                                text-scale-mode-amount
			      0)
	      start-scale (or (aref touch-screen-aux-tool 7)
			      (aset touch-screen-aux-tool 7
				    current-scale)))
        ;; Set the text scale.
	;;这里就是设置字体缩放的地方
        ;;(text-scale-set (+ start-scale
        ;;                   (round (log scale text-scale-mode-step))))
        (if (> (round (log scale text-scale-mode-step )) 0)
	    (cnfonts-increase-fontsize)
	  (cnfonts-decrease-fontsize)
	  )
        ;; Subsequently move the row which was at the centrum to its Y
        ;; position.
        (if (and (not (eq current-scale
                          text-scale-mode-amount))
                 (posn-point posn)
                 (cdr (posn-x-y posn)))
	    (touch-screen-scroll-point-to-y (posn-point posn)
					    (cdr (posn-x-y posn)))
          ;; Rather than scroll POSN's point to its old row, scroll the
          ;; display by the Y axis deltas within EVENT.
          (let ((height (window-default-line-height))
                (y-accumulator (or (aref touch-screen-aux-tool 8) 0)))
	    (setq y-accumulator (+ y-accumulator (nth 4 event)))
	    (when (or (> y-accumulator height)
		      (< y-accumulator (- height)))
	      (ignore-errors
                (if (> y-accumulator 0)
		    (scroll-down 1)
                  (scroll-up 1)))
	      (setq y-accumulator 0))
	    (aset touch-screen-aux-tool 8 y-accumulator))
          ;; Likewise for the X axis deltas.
          (let ((width (frame-char-width))
                (x-accumulator (or (aref touch-screen-aux-tool 9) 0)))
	    (setq x-accumulator (+ x-accumulator (nth 3 event)))
	    (when (or (> x-accumulator width)
		      (< x-accumulator (- width)))
	      ;; Do not hscroll if the ratio has shrunk, for that is
	      ;; generally attended by the centerpoint moving left,
	      ;; and Emacs can hscroll left even when no lines are
	      ;; truncated.
	      (unless (and (< x-accumulator 0)
                           (< ratio-diff 0))
                (if (> x-accumulator 0)
		    (scroll-right 1)
                  (scroll-left 1)))
	      (setq x-accumulator 0))
	    (aset touch-screen-aux-tool 9 x-accumulator)))))))

(provide 'abandon)
