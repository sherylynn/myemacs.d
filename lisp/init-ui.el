;; 关闭开始界面 hide startup message
(setq inhibit-startup-message t)
;;打开行号
(global-display-line-numbers-mode 1)
;;相对行号
(setq display-line-numbers-type 'relative)


;;ui
(use-package all-the-icons)

(defun my-centaur-hide-local()
  ;;其实是直接编辑的.git/下的COMMIT_EDITMSG 文件
  ;;关闭当前窗口的tab
  (when (string-equal (buffer-name) "COMMIT_EDITMSG")
    (centaur-tabs-local-mode 1)
    )
  )



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
(when (equal my-use-theme "doom-dark")
  (use-package doom-themes
    :config
    ;; Global settings (defaults)
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled
    (load-theme 'doom-dark+ t)
    ;;(load-theme 'doom-moonlight t) ;;太紫色了吧

    ;; Enable flashing mode-line on errors
    (doom-themes-visual-bell-config)
    ;; Enable custom neotree theme (all-the-icons must be installed!)
    (doom-themes-neotree-config)
    ;; or for treemacs users
    ;;(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
    ;;(doom-themes-treemacs-config)
    ;; Corrects (and improves) org-mode's native fontification.
    (doom-themes-org-config))
  )

;;偷用群友主题，失败
(when (equal my-use-theme "nasy-light")
  (use-package nasy-theme
    :quelpa (nasy-theme :fetcher github :repo "nasyxx/emacs-nasy-theme")
    ;;:custom
    ;;(nasy-theme-light/dark 'light)
    ;;(nasy-theme-light/dark 'dark)
    :config
    (load-theme 'nasy t)
    )
  )

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
(when (equal my-use-package-centaur-tabs t)
  (use-package centaur-tabs
    :hook (
	   ;;这些窗口就没必要tabs占空间拉
	   (vterm-mode . centaur-tabs-local-mode)
	   (grep-mode . centaur-tabs-local-mode)
	   (prog-mode . my-centaur-hide-local)
	   )
    :demand
    :custom
    ;;标签外观
    (centaur-tabs-style "bar")
    ;;显示icon
    (centaur-tabs-set-icons t)
    (centaur-tabs-plain-icons t)
    (centaur-tabs-gray-out-icons 'buffer)
    ;;高亮细线
    (centaur-tabs-set-bar 'under)
    (x-underline-at-descent-line t)
    ;;颜色都没什么变化
    ;;(centaur-tabs-background-color "#5300F6")
    ;;(centaur-tabs-active-bar-face (:foreground "#5300F6"))
    :config
    ;;(defface centaur-tabs-selected
    ;; '((t (:background "red" :foreground "green")))
    ;; "Face used for the selected tab."
    ;; :group 'centaur-tabs)
    (centaur-tabs-mode t)
    (centaur-tabs-headline-match)
    (defun my-left-tab()
      (interactive)
      (centaur-tabs-backward )
      )
    (defun my-right-tab()
      (interactive)
      (centaur-tabs-forward )
      )
    )
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
