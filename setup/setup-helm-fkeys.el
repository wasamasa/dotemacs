(helm-fkey "Help" "f1" "<f1>"
           '(("a" "[A]propos" helm-apropos)
             ("b" "Describe [B]indings" describe-bindings)
             ("c" "Describe [C]har" describe-char)
             ("d" "[D]ocumentation" apropos-documentation)
             ("f" "Find [F]unction" find-function)
             ("F" "Describe [F]unction" describe-function)
             ("i" "[I]nfo" info)
             ("k" "Describe [K]ey" describe-key)
             ("l" "[L]ossage" view-lossage)
             ("m" "Describe [M]odes" describe-mode)
             ("p" "[P]ackages by category" finder-by-keyword)
             ("v" "Find [V]ariable" find-variable)
             ("V" "Describe [V]ariable" describe-variable)
             ))

(helm-fkey "Packages" "f2" "<f2>"
           '(("c" "[C]olors" helm-colors)
             ("f" "[F]ind Library" find-library)
             ("g" "Customize [G]roup" customize-group)
             ("i" "Package [I]nstall" package-install)
             ;;("r" "Package [R]emove" my-package-remove)
             ("p" "[P]ackage List" package-list-packages)
             ("t" "Load [T]heme" helm-themes)
             ("v" "Customize [V]ariable" customize-variable)))

(helm-fkey "Search" "f3" "<f3>"
           '(("a" "Imenu [A]nywhere" helm-imenu-anywhere)
             ("g" "[G]rep" helm-do-grep)
             ("h" "Org [H]eadlines" helm-org-headlines)
             ("i" "[I]menu" helm-imenu)
             ("m" "[M]ulti-occur" helm-multi-occur)
             ("o" "[O]ccur" helm-occur)))

(helm-fkey "Find" "f4" "<f4>"
           '(("b" "[B]uffers" helm-buffers-list)
             ("f" "[F]ind" helm-find)
             ("i" "Find F[i]les" helm-find-files)
             ("l" "[L]ocate" helm-locate)
             ("t" "Cmd-[T]" helm-cmd-t)))

(defun my-zsh ()
  (interactive)
  (ansi-term "zsh"))

(helm-fkey "Eval" "f5" "<f5>"
           '(("c" "[C]alc" calc)
             ("e" "[E]shell" eshell)
             ("g" "Ma[g]it" magit-status)
             ("i" "[I]ELM" ielm)
             ("r" "[R]egexp" helm-regexp)
             ("s" "[S]hell" shell)
             ("t" "[T]erm" my-zsh)
             ("x" "Calculate E[x]pression" helm-calcul-expression)))

(defun my-info-emacs-lisp-intro ()
  (interactive)
  (info "eintr"))

(defun my-info-emacs-lisp-manual ()
  (interactive)
  (info "elisp"))

(defun my-info-cl ()
  (interactive)
  (info "cl"))

(defun my-info-cl-loop ()
  (interactive)
  (info "(cl) Loop facility"))

(helm-fkey "Doc" "f6" "<f6>"
           '(("c" "[C]L" my-info-cl)
             ("e" "[E]macs manual" info-emacs-manual)
             ("i" "Emacs Lisp [I]ntro" my-info-emacs-lisp-intro)
             ("l" "Emacs [L]isp manual" my-info-emacs-lisp-manual)
             ("m" "[M]an" helm-man-woman)
             ("o" "L[O]OP" my-info-cl-loop)
             ;("o" "[O]rgcard" helm-orgcard)
             ("p" "[P]ydoc" helm-pydoc)))

(helm-fkey "Insert" "f7" "<f7>"
           '(("l" "[L]aTeX Math" helm-insert-latex-math)
             ("u" "[U]CS" helm-ucs)))

(helm-fkey "Misc" "f8" "<f8>"
           '(("g" "[G]oogle Suggest" helm-google-suggest)
             ("p" "Emacs [P]rocess List" helm-list-emacs-process)
             ("s" "[S]urfraw" helm-surfraw)
             ("t" "[T]op" helm-top)
             ("w" "[W]orld time" helm-world-time)))

(helm-fkey "Distractions" "f9" "<f9>"
           '(("f" "News [F]eeds" elfeed)
             ("i" "[I]RC" my-irc)
             ("m" "E-[M]ail" mu4e)
             ("t" "[T]etris" tetris)))

(defun my-capture-journal ()
  (interactive)
  (org-capture nil "j"))

(defun my-capture-note ()
  (interactive)
  (org-capture nil "n"))

(defun my-capture-pw ()
  (interactive)
  (org-capture nil "p"))

(defun my-capture-work ()
  (interactive)
  (org-capture nil "w"))

(helm-fkey "Org Capture" "f11" "<f11>"
           '(("c" "[C]apture" org-capture)
             ("j" "[J]ournal" my-capture-journal)
             ("n" "[N]ote" my-capture-note)
             ("p" "[P]W" my-capture-pw)
             ("w" "[W]ork" my-capture-work)))

(put 'my-defcmd 'lisp-indent-function 1)
(defmacro my-defcmd (name &rest body)
  `(defun ,name () (interactive) ,@body))

(defun my-open-habits ()
  (interactive)
  (find-file "~/org/habits.org"))

(defun my-open-inbox ()
  (interactive)
  (find-file "~/org/inbox.org"))

(defun my-open-journal ()
  (interactive)
  (find-file "~/org/journal.org"))

(my-defcmd my-open-pw
  (find-file "~/org/pw.org")
  (message "hurr"))

(autoload 'cfw:open-org-calendar "calfw-org" "Open Org calendar" t)

;; habits, main, urgent, journal, note, karl, calendar, projects, ...
(helm-fkey "Org Lookup" "f12" "<f12>"
           '(("c" "[C]alendar" cfw:open-org-calendar)
             ("h" "[H]abits" my-open-habits)
             ("i" "[I]nbox" my-open-inbox)
             ("j" "[J]ournal" my-open-journal)
             ("p" "[P]W" my-open-pw)))

;; helm-pacman, helm-aur (compare helm-apt)
;; helm-dictionary
;; helm-project-persist, helm-projectile
;;
;; helm-etags-select
;; helm-semantic

(provide 'setup-helm-fkeys)
