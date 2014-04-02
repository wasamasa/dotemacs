(my-eval-after tramp-cache
  (setq tramp-persistency-file-name (concat user-emacs-directory "etc/tramp")))
(my-eval-after tramp-sh
  (setq tramp-remote-process-environment
        (cons "HISTFILE=''"
              (remove "HISTFILE=$HOME/.tramp_history"
                      tramp-remote-process-environment)))
  (defadvice tramp-maybe-open-connection (before no-hist activate)
    (setenv "HISTFILE" "")))

(provide 'setup-tramp)
