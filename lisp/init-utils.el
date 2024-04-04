(defun checkbox-insert ()
  "insert checkbox" ;;need desc
  (interactive) ;;need interactive
  (insert "- [ ]")
  (evil-escape )
  (org-update-checkbox-count-maybe )
       )
(defun insert-now-time()
  "insert now time"
  (interactive)
  (org-time-stamp-inactive "HH:MM")
  )
(defun set-input-method-rime()
  "set input method rime"
  (interactive)
  (set-input-method 'rime)
  )
(defun insert-now-schedule()
  "insert now schedule"
  (interactive)
  (org-schedule "HH:MM")
  )
(defun todo-insert ()
  "insert todo" ;;need desc
  (interactive) ;;need interactive
  (org-insert-todo-heading t)
  ;;(insert "TODO")
  ;;(org-todo "t")
  (org-update-checkbox-count-maybe )
       )
(defun open-file-in-right-window (filename)
  "在右边窗口中打开指定的文件。"
  (interactive "FEnter file name: ")
  (let ((new-buffer (find-file-noselect filename)))
    (select-window (split-window-right))
    (set-window-buffer (selected-window) new-buffer)))

(defun configure-emacs ()
  "configure emacs"
  (interactive)
  ;;(find-file "~/.emacs.d_my/packages.el")
  (find-file "~/.emacs.d_my/init.el")
  (open-file-in-right-window "~/.emacs.d_my/lisp/init-utils.el")
  )
(defun reload-emacs ()
  "reload emacs"
  (interactive)
  ;;重新加载
  (load-file "~/.emacs.d_my/init.el")
  )
(defun open-myorg()
  "configure emacs"
  (interactive)
  (find-file "~/work/todo.org")
  )
(defun async-shell-command-no-window
    (command)
  (interactive)
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))

(provide 'init-utils)
