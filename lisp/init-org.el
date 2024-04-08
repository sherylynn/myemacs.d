;;evil下一些快捷键的绑定
(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  )

;;org-bars 这个包只能在图形下进行
(when (display-graphic-p)
  (when (< emacs-major-version 30)
    (use-package org-bars
      :quelpa (org-bars :fetcher github :repo "tonyaldon/org-bars")
      :config
      (add-hook 'org-mode-hook #'org-bars-mode)
      )
    )
  )

;;换一个包试试, 这个包写的不好
;;太丑了这个包
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
(provide 'init-org)
