;; ~/.emacs.d/init.el
;;加载自己的方法,在 lisp 文件夹下的
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;默认终端 vterm
;;(setq my-use-package-terminal "eshell")
;;需要全局变量
(defvar my-use-package-terminal "eshell")
;;init-termux 中会改默认终端
(require 'init-termux)
(require 'init-utils)
;;异步获取自动更新
(async-shell-command-no-window "git -C ~/.emacs.d_my pull")

;;加载 use-package 和源 （把设置分离出去了，因为很少动)
(require 'init-package)
;;为了更好的测试一下启动时间
(use-package benchmark-init
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
  )

;;load terminal, 跟据 my-use-package-terminal 决定终端
(require 'init-terminal)

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

;; package switch
(setq my-use-package-vim "evil")
;;(setq my-use-package-vim "meow")

;;leader key
;;(setq my-use-package-leader "evil-leader")  ;;evil-leader 没法复合键位
(setq my-use-package-leader "general") ;; general 配置未完成，可以用 whichkey 提示, 发现都不能叠词，算了
;;(setq my-use-package-leader "evil") ;; 发现可以直接用 evil 来配置 配置方式和 general 有点像, 少安装个包, 也和 evil-leader 一样没法使用复合键位

;;加载 emacs 重启的插件，方便调试 emacs
(use-package restart-emacs
  :config
  ;;重启后重新打开当前窗口
  (setq restart-emacs-restore-frames t)
  )

(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))


;;加载 evil 相关插件（把 evil 分离出去了，因为很少动)
(require 'init-evil)

;;加载 org 相关插件（把 org 分离出去了，因为很少动)
(require 'init-org)

(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  )

;;2 is good
;;
(setq tab-width 2)
;;ui
(use-package all-the-icons)
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
;;emacs 自动加载外部修改过的文件
(global-auto-revert-mode 1)
;;y or n 不要 yes or no
(fset 'yes-or-no-p 'y-or-n-p)
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
(use-package dashboard
  :config
  (progn
    (dashboard-setup-startup-hook)))
;;熟悉的文件栏
(use-package neotree
  ;;需要 all the icon 包
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
;;elisp ()括号🌈彩虹
(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))
;;自动括号 29.3 的 emacs 还不支持:vc 的命令
;;(when (< emacs-major-version 30)
;;    (use-package awesome-pair
;;    :quelpa (awesome-pair :fetcher github :repo "manateelazycat/awesome-pair")
;;    )
;;  )
;;(use-package awesome-pair
;;:vc (:url "" :rev :newest)
;;)
;;所以使用旧的括号匹配
;;(use-package paredit) ;;发现还是没匹配，用 emacs 自带的
(electric-pair-mode 1)

;; great for programmers
(use-package format-all :ensure t :defer t
  ;; 开启保存时自动格式化
  :hook (prog-mode . format-all-mode)
  ;; 绑定一个手动格式化的快捷键
  :bind ("C-c f" . #'format-all-region-or-buffer))
;;来点语法高亮,自动设置 treesit
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (setq treesit-font-lock-level 4)
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
;;git
(use-package magit)

;;(use-package fingertip) ;;又是 github 包
;;lsp 客户端
(use-package eglot
  :hook (prog-mode . eglot-ensure)
  :bind ("C-c e f" . eglot-format))
;;加载快捷键
(require 'init-key)
;;加载补全配置
(require 'init-completion)

;;pyim
(require 'init-pyim)


;;关闭 emacs 的 custom 在 init 文件里瞎下蛋拉屎
(setq custom-file "~/.emacs.d_my/custom.el")
(load custom-file 'no-error 'no-message)
