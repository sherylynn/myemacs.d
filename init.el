;; ~/.emacs.d/init.el
;;加载自己的方法,在lisp文件夹下的
;;(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;(require 'init-utils)
;;设置tuna源
(setq package-archives '(
  ("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
  ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
  ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; 以下用来 bootstrap use-package 自己。在上文设置好软件源后，

;; 如果 use-package 没安装
(unless (package-installed-p 'use-package)
  ;; 更新本地缓存
  (package-refresh-contents)
  ;; 之后安装它。use-package 应该是你配置中唯一一个需要这样安装的包。
  (package-install 'use-package))

(require 'use-package)
;; 让 use-package 永远按需安装软件包
(setq use-package-always-ensure t)

;; 之后就可以使用它了。
;; 比如上文安装并 require better-defaults 的过程就可以简化为这一行：
;; 1. 它会判断是否已安装。没有时才会更新 package 缓存并安装它
;; 2. 它会自动 (require)
;; 3. 它有很多配置项能让你控制每个环节，从而做到把和这个软件包有关的所

;;leader键
(use-package evil-leader
  :ensure t
  :init
  ;;evil-collection 的 warning, 不得不关闭
  (setq evil-want-keybinding nil)
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "SPC")
  (evil-leader/set-key
    ;;org file
    "zo" 'find-file
    ;;reload init.el
    "zr" 'find-file
    ;;init.el
    "ze" 'find-file
    ;;neotree
    "1" 'neotree-toggle
    ;;magit-status
    "gg" 'magit-status
    )
  )
;;evil as vim
(use-package evil
  :ensure t
  :init
  ;;evil-collection 的 warning
  (setq evil-want-keybinding nil)
  :config
    (evil-mode 1))
;;surround,添加环绕字符
(use-package evil-surround
  :after evil
  :ensure t
  :config
    (global-evil-surround-mode 1))
;;一些包括evil for magit的操作合集
(use-package evil-collection
  :after evil
  :ensure t
  :config
    (evil-collection-init))
;;退出evil的快捷方式
(use-package evil-escape
  :after evil
  :ensure t
  :config
  (evil-escape-mode)
  (setq-default evil-escape-key-sequence "jk")
  )
;;其他全局按键
(global-set-key (kbd "C-g") 'evil-escape)

(use-package which-key
  :config
  (which-key-mode))
;;pyim
;;(use-package pyim)
;;ui
(use-package all-the-icons)
;; 关闭开始界面 hide startup message
(setq inhibit-startup-message t)
;;better-defaults 比如关闭工具栏等有趣的行为
(use-package better-defaults)
;;关闭烦人的warning,和我有毛线关系？
(setq warning-minimum-level :error)
;;偷用doom的主题
(use-package doom-themes
  :ensure t
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
