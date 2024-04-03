;; ~/.emacs.d/init.el
;;加载自己的方法,在lisp文件夹下的
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-utils)
;;异步获取自动更新
(async-shell-command-no-window "git -C ~/.emacs.d_my pull")

;;设置tuna源
(setq package-archives '(
  ("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
  ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
  ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; emacs 29以后use-package 已经内置
(when (< emacs-major-version 29)
  ;; 以下用来 bootstrap use-package 自己。在上文设置好软件源后，
  ;; 如果 use-package 没安装
  (unless (package-installed-p 'use-package)
    ;; 更新本地缓存
    (package-refresh-contents)
    ;; 之后安装它。use-package 应该是你配置中唯一一个需要这样安装的包。
    (package-install 'use-package))

  (require 'use-package)
  )
;; 让 use-package 永远按需安装软件包 不知道为啥不行了
(require 'use-package-ensure)
(setq use-package-always-ensure t)
;; 让 use-package 永远按需加载软件包 ;;结果全没加载，无语
;;(setq use-package-always-defer t)
;; 之后就可以使用它了。
;; 比如上文安装并 require better-defaults 的过程就可以简化为这一行：
;; 1. 它会判断是否已安装。没有时才会更新 package 缓存并安装它
;; 2. 它会自动 (require)
;; 3. 它有很多配置项能让你控制每个环节，从而做到把和这个软件包有关的所

;; package switch
(setq my-use-package-vim "evil")
;;(setq my-use-package-vim "meow")

;;leader key
;;(setq my-use-package-leader "evil-leader")  ;;evil-leader没法复合键位
(setq my-use-package-leader "general") ;; general 配置未完成，可以用whichkey提示, 发现都不能叠词，算了
;;(setq my-use-package-leader "evil") ;; 发现可以直接用evil来配置 配置方式和general有点像, 少安装个包, 也和evil-leader一样没法使用复合键位

(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  )

;;按键总是最重要的，让我们来开始which-key（leader 时候general也会用到)
(use-package which-key
  :config
  (which-key-mode))

;;接下来让我们vim起来
(when (equal my-use-package-vim "evil")
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
        "zr" 'find-file
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
        "zr" '(find-file :wk "reload emacs")
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
     )   
    ))
    ;;EVIL:: as vim
    (use-package evil
    :init
    ;;evil-collection 的 warning
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1)
    ;; evil也自带 leader模式
    (when (equal my-use-package-leader "evil")
      (evil-set-leader nil (kbd "SPC"))
      ;;org file
      (evil-define-key 'normal 'global (kbd "<leader>zo") 'open-myorg)
      ;;init.el
      (evil-define-key 'normal 'global (kbd "<leader>ze") 'configure-emacs)
      ;;neotree
      (evil-define-key 'normal 'global (kbd "<leader>1") 'neotree-toggle)
      ;;quit buffer
      (evil-define-key 'normal 'global (kbd "<leader>q") 'kill-buffer-and-window)
      ;;quit emacs
      (evil-define-key 'normal 'global (kbd "<leader>zz") 'kill-emacs);;一样废物，不能和上面的leaderq重合
      ;;magit-status
      (evil-define-key 'normal 'global (kbd "<leader>gg") 'magit-status)
      
      ))
    ;;surround,添加环绕字符
    (use-package evil-surround
    :after evil
    :config
        (global-evil-surround-mode 1))
    ;;一些包括evil for magit的操作合集
    (use-package evil-collection
    :after evil
    :config
        (evil-collection-init))
    ;;退出evil的快捷方式
    (use-package evil-escape
    :after evil
    :config
    (evil-escape-mode)
    (setq-default evil-escape-key-sequence "jk")
    )
    ;;其他全局按键
    (global-set-key (kbd "C-g") 'evil-escape)
);;my-use-package when evil
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
;;
(global-display-line-numbers-mode 1)
;;
(setq display-line-numbers-type 'relative)
;;better-defaults 比如关闭工具栏等有趣的行为
(use-package better-defaults)
;;关闭烦人的warning,和我有毛线关系？
(setq warning-minimum-level :error)
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
;;mini
;;关闭emacs的custom在init文件里瞎下蛋拉屎
(setq custom-file "~/.emacs.d_my/custom.el")
(load custom-file 'noerror)
