;;2 is good
(setq tab-width 2)

;;emacs 自动加载外部修改过的文件
(global-auto-revert-mode 1)

;;y or n 不要 yes or no
(fset 'yes-or-no-p 'y-or-n-p)

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
;;不使用自带的括号匹配
;;(electric-pair-mode 1)

;;elisp ()括号🌈彩虹
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  )

;; great for programmers
(use-package format-all :defer t
  ;; 开启保存时自动格式化
  :hook (prog-mode . format-all-mode)
  ;; 绑定一个手动格式化的快捷键
  :bind ("C-c f" . #'format-all-region-or-buffer))

;;(use-package fingertip) ;;又是 github 包
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

;;lsp 客户端
;;(use-package eglot
;;:hook (prog-mode . eglot-ensure)
;;:bind ("C-c e f" . eglot-format))

(provide 'init-program)
