;; -*- lexical-binding: t -*-
(require 'helm)
(require 's)

(defvar helm-fkey-keymap
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map helm-map)
    (dolist (key (number-sequence ?! ?~))
      (define-key map (kbd (string key)) 'exit-minibuffer))
    map))

(defun helm-fkey-call-function (data)
  "Calls the function associated to the last key pressed by
looking up DATA"
  (let ((command (caddr (assoc (string last-command-event) data))))
    (when command
      (command-execute command 'record))))

(defface helm-fkey-key-face '((t (:foreground "red" :weight bold)))
  "Face for the highlighted key")
(defface helm-fkey-bracket-face '((t (:weight bold)))
  "Face for the highlighted brackets")

(defun helm-fkey-propertize-candidate (str)
  "Propertizes a helm-fkey candidate, both brackets and the
enclosed glyph get a distinct face"
  (let* ((split-str (s-split "\\(\\[\\|\\]\\)" str))
         (beg (first split-str))
         (opening-bracket "[")
         (key (second split-str))
         (closing-bracket "]")
         (rest (third split-str)))
    (s-concat beg
              (propertize opening-bracket 'face 'helm-fkey-bracket-face)
              (propertize key 'face 'helm-fkey-key-face)
              (propertize closing-bracket 'face 'helm-fkey-bracket-face)
              rest)))

(defun helm-fkey-prettify (candidates)
  "Applies `helm-fkey-propertize-candidate' to CANDIDATES"
  (mapcar 'helm-fkey-propertize-candidate candidates))

(defmacro helm-fkey (label key bind data)
  "Creates and binds a helm-fkey function"
  (let ((func-name (intern (concat "helm-" key))))
    `(progn
       (defun ,func-name ()
         (interactive)
         (let* ((data ,data)
                (source '((name . ,label)
                          (candidates . (lambda () (mapcar 'cadr ,data)))
                          (candidate-transformer helm-fkey-prettify)
                          (action ("Execute" . (lambda (_) (helm-fkey-call-function ,data)))))))
           (helm :sources source :keymap helm-fkey-keymap :prompt "Key: " :buffer ,(concat "*helm-" key))))
       (global-set-key (kbd ,bind) ',func-name))))

;;------------------

(helm-fkey "Help" "f1" "<f1>"
           '(("a" "[A]propos" helm-apropos)
             ("b" "Describe [B]indings" describe-bindings)
             ("c" "Describe [C]har" describe-char)
             ("d" "[D]ocumentation" apropos-documentation)
             ("f" "Describe [F]unction" describe-function)
             ("F" "Find [F]unction" find-function)
             ("i" "[I]nfo" info)
             ("k" "Describe [K]ey" describe-key)
             ("l" "[L]ossage" view-lossage)
             ("m" "Describe [M]odes" describe-mode)
             ("p" "[P]ackages by category" finder-by-keyword)
             ("v" "Describe [V]ariable" describe-variable)
             ("V" "Find [V]ariable" find-variable)))

(helm-fkey "Packages" "f2" "<f2>"
           '(("c" "[C]olors" helm-colors)
             ("f" "[F]ind Library" find-library)
             ("g" "Customize [G]roup" customize-group)
             ("i" "Package [I]nstall" package-install)
             ;;("r" "Package [R]emove" wasa-package-remove)
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

(helm-fkey "Eval" "f5" "<f5>"
           '(("c" "[C]alc" calc)
             ("e" "[E]val Expression" helm-eval-expression-with-eldoc)
             ("g" "Ma[g]it" magit-status)
             ("i" "[I]ELM" ielm)
             ("r" "[R]egexp" helm-regexp)
             ("s" "[S]hell" shell)
             ("t" "ANSI [T]erm" ansi-term)
             ("x" "Calculate E[x]pression" helm-calcul-expression)))

(defun my-info-emacs-lisp-intro ()
  (interactive)
  (info "eintr"))

(defun my-info-emacs-lisp-manual ()
  (interactive)
  (info "elisp"))

(helm-fkey "Doc" "f6" "<f6>"
           '(("e" "[E]macs manual" info-emacs-manual)
             ("i" "Emacs Lisp [I]ntro" my-info-emacs-lisp-intro)
             ("l" "Emacs [L]isp manual" my-info-emacs-lisp-manual)
             ("m" "[M]an" helm-man-woman)
             ("o" "[O]rgcard" helm-orgcard)
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
           '(("d" "Tumblr [D]ashboard" tumblesocks-view-dashboard)
             ("f" "News [F]eeds" elfeed)
             ("i" "[I]RC" wasa-irc)
             ("m" "E-[M]ail" mu4e)
             ("t" "[T]etris" tetris)))

;; helm-pacman, helm-aur (compare helm-apt)
;; helm-dictionary
;; helm-project-persist, helm-projectile
;;
;; helm-etags-select
;; helm-semantic

(provide 'helm-fkeys)
