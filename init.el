;; ~/.emacs.d/init.el
;;---------------GC 启动优化----begin---------------
;;(let (;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
;;     (gc-cons-threshold most-positive-fixnum)
;; 清空避免加载远程文件的时候分析文件。
;;      (file-name-handler-alist nil))

;;来自 purcell 的性能优化
;; Adjust garbage collection threshold for early startup (see use of gcmh below)
(setq gc-cons-threshold (* 128 1024 1024))
;; Process performance tuning
(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)
;; General performance tuning
(setq jit-lock-defer-time 0)
;; Emacs 配置文件内容写到下面.

;;加载自己的方法,在 lisp 文件夹下的
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;默认终端 vterm
;;(setq my-use-package-terminal "eshell")
;;需要全局变量
(defvar my-use-package-terminal "vterm")
;;更灵活 treemacs
(defvar my-use-package-filetree "neotree")
;; neotree 支持 android 点击触摸
;;(defvar my-use-package-filetree "treemacs")

;;org modern or org normal
(defvar my-use-package-org "org-normal")

;;中文美化包
;;(defvar my-use-package-cn "emacs")
(defvar my-use-package-cn "cnfonts")

;;主题颜色
(defvar my-use-theme "doom-dark")
;;(defvar my-use-theme "nasy-light")

;;我用的 tab-bar
;;发现这俩包不冲突
;;但是 awesome 包在 android 下不能点击，centaur 可以
(defvar my-use-package-tab-bar t)
(defvar my-use-package-awesome-tab nil)
(defvar my-use-package-centaur-tabs t)

;;加载一些 init-key and init command 可能用到的方法
(require 'init-utils)

;;init-system 中会改默认终端，改变 mouse
(require 'init-system)

;;异步获取自动更新
(async-shell-command-no-window "git -C ~/.emacs.d pull")
;;完成我其他的项目
(async-shell-command-no-window "git -C ~/work pull")
(async-shell-command-no-window "git -C ~/sh pull")
;;(async-shell-command-no-window "git -C ~/.doom.d/ pull")
;;(async-shell-command "git -C ~/work pull")
;;不管是哪个版本的，都会提示已经有命令在运行了

;;加快启动速度
;;(setq my-init-config-timeup "normal")
(setq my-init-config-timeup "fast")
;;(setq my-init-config-timeup "debug")

;;加载 use-package 和源 （把设置分离出去了，因为很少动)
(require 'init-package)


;;使用 GC 优化包
(use-package gcmh
  :config
  (gcmh-mode 1)
  )
;;load terminal, 跟据 my-use-package-terminal 决定终端
(require 'init-terminal)

;; package switch
(setq my-use-package-vim "evil")
;;(setq my-use-package-vim "meow")

;; input method swith
;;mac下有一点点麻烦，还要什么动态模块
;;(setq my-use-package-input "rime")
(setq my-use-package-input "pyim")

;;leader key
;;(setq my-use-package-leader "evil-leader")  ;;evil-leader 没法复合键位
(setq my-use-package-leader "general") ;; general 配置未完成，可以用 whichkey 提示, 发现都不能叠词，算了
;;(setq my-use-package-leader "evil") ;; 发现可以直接用 evil 来配置 配置方式和 general 有点像, 少安装个包, 也和 evil-leader 一样没法使用复合键位

;;加载 emacs 重启的插件，方便调试 emacs
(use-package restart-emacs
  :defer t
  :config
  ;;重启后重新打开当前窗口
  (setq restart-emacs-restore-frames t)
  )

(use-package saveplace
  :defer t
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

;;加载 program 配置
(require 'init-program)

;;加载 filetree
(require 'init-filetree)

(cond
 ;;pyim
 ((equal my-use-package-input "pyim")
  (require 'init-pyim))
 ;;rime
 ((equal my-use-package-input "rime")
  (require 'init-rime)
  )
 )


;;加载 UI 界面
(require 'init-ui)

;;加载快捷键
(require 'init-key)
;;加载补全配置
(require 'init-completion)

;;试用期的代码
(require 'init-test)

;;尝试过后来又不用的代码
;;(require 'abandon)

;;关闭 emacs 的 custom 在 init 文件里瞎下蛋拉屎
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'no-error 'no-message)

;;自动保存状态重新自动打开
;;(desktop-save-mode 1)
(setq desktop-save t)
(setq desktop-path "~/.emacs.d/")
(setq desktop-base-file-name ".emacs.desktop")
;;(desktop-read "~/")

;; )


;;---------------GC 启动优化----end---------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-vc-selected-packages
   '((pyim-tsinghua-dict :url "https://github.com/redguardtoo/pyim-tsinghua-dict"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
