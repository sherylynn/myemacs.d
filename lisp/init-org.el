;;个人日程列表文件
(setq org-agenda-files (list "~/work/todo.org"))
(setq org-todo-keywords
      '((sequence "TODO(t)" "KILL(k)" "WAIT(w)" "DONE(d)" )))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "green" :weight bold))
	("KILL" . (:foreground "red" :weight bold))
	("WAIT" . (:foreground "yellow" :weight bold))
	("DONE" . (:foreground "grey" :weight bold))
	))
(setq
 ;;跨越10天
 org-agenda-span 10)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-start-day "-3d")
;;agenda的时候就不提示不想要的状态
(setq org-agenda-custom-commands
      '(
        ("w" "Agenda for work"
         ((agenda "" ((org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo '("TODO")))))
          (todo "WAIT")
          ;;(alltodo "")
          (tags "note"))
         )
        ("n" todo "NOTE")))
;;evil下一些快捷键的绑定
(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  )

;;org-bars 这个包只能在图形下进行
;;(when (display-graphic-p)
;;(when (< emacs-major-version 30)
;;(use-package org-bars
;;:quelpa (org-bars :fetcher github :repo "tonyaldon/org-bars")
;;:config
;;(add-hook 'org-mode-hook #'org-bars-mode)
;;)
;;)
;;)

;;换一个包试试, 这个包写的不好
;;太丑了这个包,终端下效果不好，表格竖线太粗
;;(when (< emacs-major-version 30)
;;(use-package org-visual-outline
;;:quelpa (org-visual-outline :fetcher github :repo "legalnonsense/org-visual-outline")
;;:config
;;(org-dynamic-bullets-mode)
;;(org-visual-indent-mode)
;;)
;;)
;;(when (< emacs-major-version 30)
;;(use-package org-dynamic-bullets
;;:quelpa (org-dynamic-bullets :fetcher url :url "https://github.com/legalnonsense/org-visual-outline/raw/master/org-dynamic-bullets.el")
;;:config
;;(org-dynamic-bullets-mode)
;;)
;;(use-package org-visual-indent
;;:quelpa (org-visual-indent :fetcher url :url "https://github.com/legalnonsense/org-visual-outline/raw/master/org-visual-indent.el")
;;:config
;;(org-visual-indent-mode)
;;)
;;)

;;用一个写了corfu的作者的包
;;可以终端下进行渲染，但是没有缩进对齐
;;终端下面还是丑陋的竖线，实在是太粗了
(use-package org-modern
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
     ("WAIT" :background "yellow" :foreground "green")
     ("DONE" :background "black" :foreground "white")
     ))
  ;; Org modern settings
  ;;(org-modern-star nil)
  ;;(org-modern-priority nil)
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
;;(when (< emacs-major-version 30)
(use-package org-modern-indent
  :custom
  (org-startup-indented t)
  :quelpa  (org-modern-indent :fetcher github :repo "jdtsmith/org-modern-indent")
  :config ; add late to hook
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))
;; )
(provide 'init-org)
