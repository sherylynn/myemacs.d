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
(defun configure-emacs ()
  "configure emacs"
  (interactive)
  ;;(find-file "~/.emacs.d_my/packages.el")
  (find-file "~/.emacs.d_my/init.el")
  (find-file "~/.emacs.d_my/lisp/init-utils.el")
  )
(defun open-myorg()
  "configure emacs"
  (interactive)
  (find-file "~/work/todo.org")
  )

(provide 'init-utils)
