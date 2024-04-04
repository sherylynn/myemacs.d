;; ~/.emacs.d/init.el
;;加载自己的方法,在lisp文件夹下的
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-utils)
;;异步获取自动更新
(async-shell-command-no-window "git -C ~/.emacs.d_my pull")

;;来自purcell的性能优化
;; Adjust garbage collection threshold for early startup (see use of gcmh below)
(setq gc-cons-threshold (* 128 1024 1024))
;; Process performance tuning
(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)
;; General performance tuning
(setq jit-lock-defer-time 0)

;;加载use-package 和源 （把设置分离出去了，因为很少动)
(require 'init-package)

;; package switch
(setq my-use-package-vim "evil")
;;(setq my-use-package-vim "meow")

;;leader key
;;(setq my-use-package-leader "evil-leader")  ;;evil-leader没法复合键位
(setq my-use-package-leader "general") ;; general 配置未完成，可以用whichkey提示, 发现都不能叠词，算了
;;(setq my-use-package-leader "evil") ;; 发现可以直接用evil来配置 配置方式和general有点像, 少安装个包, 也和evil-leader一样没法使用复合键位

;;加载emacs重启的插件，方便调试emacs
(use-package restart-emacs
  :config
  ;;重启后重新打开当前窗口
  (setq restart-emacs-restore-frames t)
  )

(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))


;;加载evil相关插件（把evil分离出去了，因为很少动)
(require 'init-evil)

;;加载org相关插件（把org分离出去了，因为很少动)
(require 'init-org)

(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  )

;;按键总是最重要的，让我们来开始which-key（leader 时候general也会用到)
;;which-key是快捷键提示
(use-package which-key
  :config
  (which-key-mode))

;;general是通用的按键绑定
(when (equal my-use-package-leader "general")
(use-package general
:config
;;这样就指定了 normal state 下的 leader 键是 SPC、其余的 insert / visual /emacs state 下是 C-,。之后用这个新创建的 definer 分配键位就好：
(general-create-definer my-leader-def
:states '(normal insert visual emacs)
:prefix "SPC"
:non-normal-prefix "C-,")
;;定义键位时，可以用 :which-key 或简写 :wk 来指定 which-key 所显示的文字：
(my-leader-def
    ;;z about editor
    "z" '(:wk "editor")
    ;;org file
    "zo" '(open-myorg :wk "open my orgfile")
    ;;reload init.el
    "zr" '(reload-emacs :wk "reload emacs")
    ;;init.el
    "ze" '(configure-emacs :wk "edit emacs configure")
    ;;neotree
    "1" '(neotree-toggle :wk "toggle neotree")
    ;;quit buffer
    "q" '(kill-buffer-and-window :wk "quit buffer")
    ;;quit emacs
    "zz" 'kill-emacs 
    ;;magit-status
    "g" '(:wk "git")
    "gg" '(magit-status :wk "magit-status")
    ;;redo reload restart
    "r" '(:wk "re-do reload restart")
    "rd" 'find-function
    "rl" 'reload-emacs
    "rr" 'restart-emacs
    "rc" '(package-recompile-all :wk "recompile package")
    ;;windows 
    "w" '(:wk "windows")
    "wq" 'kill-buffer-and-window
    "wh" 'evil-window-left ;;C-w h
    "wj" 'evil-window-down ;;C-w j
    "wk" 'evil-window-up ;;C-w k
    "wl" 'evil-window-right ;;C-w l
    ;;help
    "h" '(:wk "help")
    "hf" 'describe-function ;;"hf" 'find-function
    "hv" 'describe-variable ;;"hv" 'find-variable
    "hk" 'find-function-on-key
    )   
))
(when (equal my-use-package-vim "meow")
  (use-package meow
    :config
    ;;(meow-setup)
    (meow-global-mode 1)
    )
)
;;pyim
;;(use-package pyim)
;;2 is good
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
(use-package better-defaults)
;;高亮当前行
(global-hl-line-mode 1)
;;关闭烦人的warning,和我有毛线关系？
(setq warning-minimum-level :error)
;;emacs 自动加载外部修改过的文件
(global-auto-revert-mode 1)
;;y or n 不要 yes or no
(fset 'yes-or-no-p 'y-or-n-p)
;;偷用doom的主题
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
;;偷用doom的状态栏
(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-project-detection 'project))
;;熟悉的状态栏
(use-package neotree
  ;;需要all the icon 包
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
;;elisp ()括号🌈彩虹
(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))
;;自动括号 29.3的emacs还不支持:vc 的命令
;;(when (< emacs-major-version 30)
;;    (use-package awesome-pair 
;;    :quelpa (awesome-pair :fetcher github :repo "manateelazycat/awesome-pair")
;;    )
;;  )
;;(use-package awesome-pair
;;:vc (:url "" :rev :newest)
  ;;)

;;git
(use-package magit)
;;in-buffer补全
;;corfu是前端，还需要后端
(use-package corfu
  ;; Optional customizations
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  ;; (setq completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (setq text-mode-ispell-word-completion nil)

  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (setq read-extended-command-predicate #'command-completion-default-include-p))
;; corfu in terminal
(use-package corfu-terminal
  :ensure t
  :config
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)
  )
)
;;minibuffer补全
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;;保存光标历史，记住上个命令,配合vertico使用更香
(use-package savehist
  :init
  (savehist-mode)
  )
;;使用orderless无序补全
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))



;;关闭emacs的custom在init文件里瞎下蛋拉屎
(setq custom-file "~/.emacs.d_my/custom.el")
(load custom-file 'no-error 'no-message)
