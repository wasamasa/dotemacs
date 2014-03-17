(setq smex-save-file (concat user-emacs-directory "etc/smex")
      smex-history-length 50)
(smex-initialize)

(defun helm-smex-items ()
  (smex-rebuild-cache)
  (smex-convert-for-ido smex-cache))

(defun helm-smex-execute-command (command)
  (command-execute command 'record)
  (smex-rank command))

(setq helm-smex-source
  '((name . "M-x")
    (candidates . helm-smex-items)
    (coerce . intern)
    (action ("smex" . (helm-smex-execute-command)))))

(defun helm-smex ()
  (interactive)
  (helm :sources 'helm-smex-source :buffer "*helm-smex*"))

(global-set-key (kbd "M-x") 'helm-smex)

(provide 'helm-smex)
