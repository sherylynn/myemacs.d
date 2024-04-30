;;个人日程列表文件
(setq org-agenda-files (list "~/work/todo.org"))
(setq org-todo-keywords
      ;;无语了居然是用分隔符号来区分是否完成
      '((sequence "TODO(t)"  "WAIT(w)" "|" "KILL(k)" "DONE(d)" )))
(setq org-not-done-keywords '("TODO"))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "green" :weight bold))
	("WAIT" . (:foreground "yellow" :weight bold))
	("KILL" . (:foreground "red" :weight bold))
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

;;org没法直接use package
;;(use-package org)
;;这个是原本emacs自带的让每行只显示一个星号
(defun my-org-mode()
  (setq org-hide-leading-stars t)
  ;;开启 org 下面自动换行
  (setq truncate-lines nil)
  ;;打开 buffer 大小，显示当前字数
  (size-indication-mode t)

  ;;当启动 org 的时候关闭行号
  (display-line-numbers-mode 0)

  ;;打开缩进
  (org-indent-mode)
  )

(when (equal my-use-package-org "org-normal")
  (add-hook 'org-mode-hook 'my-org-mode)
  )


(when (equal my-use-package-org "org-modern")
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
  )

;;evil下一些快捷键的绑定
(use-package evil-org
  ;;  :defer t
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  )

(provide 'init-org)
