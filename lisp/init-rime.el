(use-package rime
  :custom
  (default-input-method "rime")
  :config
  (when (file-exists-p "/home/linuxbrew")
    (setq rime-emacs-module-header-root
          "/home/linuxbrew/.linuxbrew/include"
          ))
  (setq rime-show-candidate 'posframe)
  (defun toggle-rime-show-candidate()
    "toggle rime show candidate"
    (interactive)
    (if (equal rime-show-candidate 'posframe)
	(setq rime-show-candidate 'minibuffer)
      (setq rime-show-candidate 'posframe))
    )
  (setq rime-user-data-dir "~/rime")
  (setq rime-share-data-dir "~/rime")
  ;;rime-user-data-dir "~/storage/download/rime")

  )
(provide 'init-rime)
