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
;;evil下一些快捷键的绑定

(use-package evil-org
  ;;  :defer t
  :after org
  :hook (
	 org-mode . (lambda ()
		      evil-org-mode
		      ;;当启动 org 的时候关闭行号
		      (display-line-numbers-mode 0)

		      ;;打开 buffer 大小，显示当前字数
		      (size-indication-mode)

		      ;;开启 org 下面自动换行
		      (setq truncate-lines nil)
		      )
	 )
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  )

;;简单的把org前面弄漂亮
(use-package org-superstar
  :defer t
  :hook (orgmode . org-superstar-mode)
  ;;:custom
  ;;()
  :config
  ;;(org-superstar-configure-like-org-bullets)
  ;; This is usually the default, but keep in mind it must be nil
  (setq org-hide-leading-stars nil)
  ;; This line is necessary.
  (setq org-superstar-leading-bullet ?\s)
  ;;我不用org-indent所以不知道什么效果
  ;; If you use Org Indent you also need to add this, otherwise the
  ;; above has no effect while Indent is enabled.
  ;;(setq org-indent-mode-turns-on-hiding-stars nil)
  ;;删掉星星的空白
  ;;(setq org-superstar-remove-leading-stars t)
  )
(provide 'init-org)
