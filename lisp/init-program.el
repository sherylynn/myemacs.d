;;2 is good
(setq tab-width 2)

;;emacs 自动加载外部修改过的文件
(global-auto-revert-mode 1)

;;y or n 不要 yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;;不使用自带的括号匹配
(electric-pair-mode 1)

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

(unless (< emacs-major-version 29)
  ;;来点语法高亮,自动设置 treesit
  ;;不支持29以下的emacs
  (use-package treesit-auto
    :defer t
    :custom
    (treesit-auto-install 'prompt)
    :config
    (setq treesit-font-lock-level 4)
    (treesit-auto-add-to-auto-mode-alist 'all)
    (global-treesit-auto-mode))
  )
;;git
(use-package magit
  :defer t
  :config
  (when (< emacs-major-version 29)
    ;;(use-package seq)
    ;;28缺少关键包，没办法
    (defun seq-keep (function sequence)
      "Apply FUNCTION to SEQUENCE and return the list of all the non-nil results."
      (delq nil (seq-map function sequence))
      )
    )
  )

;;diff-hl-mode
;;显示git变化
;;据说git-gutter有性能问题
(use-package diff-hl
  ;;:custom (diff-hl-draw-borders nil)
  ;;:custom-face
  ;;(diff-hl-change ((t (:inherit custom-changed :foreground unspecified :background unspecified))))
  ;;新增的变成加号
  ;;(diff-hl-insert ((t (:inherit diff-added :background unspecified))))
  ;;删除的变成减号
  ;;(diff-hl-delete ((t (:inherit diff-removed :background unspecified))))
  :config
  (global-diff-hl-mode)
  (unless (display-graphic-p )
    ;;在终端也显示变化
    (diff-hl-margin-mode)
    )
  )

;;lsp 客户端
;;(use-package eglot
;;:hook (prog-mode . eglot-ensure)
;;:bind ("C-c e f" . eglot-format))

(provide 'init-program)
