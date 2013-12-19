(require 's)

(setq helm-fkey-keymap
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map helm-map)
    (dolist (key (number-sequence ?! ?~))
      (define-key map (kbd (string key)) 'exit-minibuffer))
    map))

(defun helm-fkey-call-function (data)
  (let ((command (caddr (assoc (string last-command-event) data))))
    (when command
      (command-execute (intern command) 'record))))

(defun helm-fkey-propertize-candidate (str)
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
  (mapcar 'helm-fkey-propertize-candidate candidates))

;;------------------

(setq helm-f1-data
      '(("a" . ("[A]propos" "helm-apropos"))
        ("b" . ("Describe [B]indings" "describe-bindings"))
        ("c" . ("Describe [C]ommand" "describe-key-briefly"))
        ("d" . ("[D]ocumentation" "apropos-documentation"))
        ("f" . ("Describe [F]unction" "describe-function"))
        ("F" . ("Find [F]unction" "find-function"))
        ("i" . ("[I]nfo" "info"))
        ("k" . ("Describe [K]ey" "describe-key"))
        ("l" . ("[L]ossage" "view-lossage"))
        ("m" . ("Describe [M]odes" "describe-mode"))
        ("p" . ("[P]ackages by category" "finder-by-keyword"))
        ("v" . ("Describe [V]ariable" "describe-variable"))
        ("V" . ("Find [V]ariable" "find-variable"))))

(defun helm-f1-candidates ()
  (mapcar 'cadr helm-f1-data))

(setq helm-f1-source
      '((name . "Help")
        (candidates . helm-f1-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f1-call-function))))

(defun helm-f1-call-function (_)
  (helm-fkey-call-function helm-f1-data))

(defun helm-f1 ()
  (interactive)
  (helm :sources 'helm-f1-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f1*"))

;;------------------

(setq helm-f2-data
      '(("c" . ("[C]olors" "helm-colors"))
        ("f" . ("[F]ind Library" "find-library"))
        ("g" . ("Customize [G]roup" "customize-group"))
        ("i" . ("Package [I]nstall" "package-install"))
        ;("r" . ("Package [R]emove" "wasa-package-remove"))
        ("p" . ("[P]ackage List" "package-list-packages"))
        ("t" . ("Load [T]heme" "helm-themes"))
        ("v" . ("Customize [V]ariable" "customize-variable"))))

(defun helm-f2-candidates ()
  (mapcar 'cadr helm-f2-data))

(setq helm-f2-source
      '((name . "Packages")
        (candidates . helm-f2-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f2-call-function))))

(defun helm-f2-call-function (_)
  (helm-fkey-call-function helm-f2-data))

(defun helm-f2 ()
  (interactive)
  (helm :sources 'helm-f2-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f2*"))

;;------------------

(setq helm-f3-data
      '(("a" . ("Imenu [A]nywhere" "helm-imenu-anywhere"))
        ("g" . ("[G]rep" "helm-do-grep"))
        ("h" . ("Org [H]eadlines" "helm-org-headlines"))
        ("i" . ("[I]menu" "helm-imenu"))
        ("m" . ("[M]ulti-occur" "helm-multi-occur"))
        ("o" . ("[O]ccur" "helm-occur"))))

(defun helm-f3-candidates ()
  (mapcar 'cadr helm-f3-data))

(setq helm-f3-source
      '((name . "Search")
        (candidates . helm-f3-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f3-call-function))))

(defun helm-f3-call-function (_)
  (helm-fkey-call-function helm-f3-data))

(defun helm-f3 ()
  (interactive)
  (helm :sources 'helm-f3-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f3*"))

;;------------------

(setq helm-f4-data
      '(("b" . ("[B]uffers" "helm-buffers-list"))
        ("f" . ("[F]ind" "helm-find"))
        ("i" . ("Find F[i]les" "helm-find-files"))
        ("l" . ("[L]ocate" "helm-locate"))
        ("t" . ("Cmd-[T]" "helm-cmd-t"))))

(defun helm-f4-candidates ()
  (mapcar 'cadr helm-f4-data))

(setq helm-f4-source
      '((name . "Find")
        (candidates . helm-f4-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f4-call-function))))

(defun helm-f4-call-function (_)
  (helm-fkey-call-function helm-f4-data))

(defun helm-f4 ()
  (interactive)
  (helm :sources 'helm-f4-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f4*"))

;;------------------

(setq helm-f5-data
      '(("c" . ("[C]alc" "calc"))
        ("e" . ("[E]val Expression" "helm-eval-expression-with-eldoc"))
        ("i" . ("[I]ELM" "ielm"))
        ("r" . ("[R]egexp" "helm-regexp"))
        ("s" . ("[S]hell" "shell"))
        ("t" . ("ANSI [T]erm" "ansi-term"))
        ("x" . ("Calculate E[x]pression" "helm-calcul-expression"))))

(defun helm-f5-candidates ()
  (mapcar 'cadr helm-f5-data))

(setq helm-f5-source
      '((name . "Eval")
        (candidates . helm-f5-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f5-call-function))))

(defun helm-f5-call-function (_)
  (helm-fkey-call-function helm-f5-data))

(defun helm-f5 ()
  (interactive)
  (helm :sources 'helm-f5-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f5*"))

;;------------------

(setq helm-f6-data
        '(("e" . ("[E]macs manual" "info-emacs-manual"))
          ("m" . ("[M]an" "helm-man-woman"))
          ("o" . ("[O]rgcard" "helm-orgcard"))
          ("p" . ("[P]ydoc" "helm-pydoc"))))

(defun helm-f6-candidates ()
  (mapcar 'cadr helm-f6-data))

(setq helm-f6-source
      '((name . "Doc")
        (candidates . helm-f6-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f6-call-function))))

(defun helm-f6-call-function (_)
  (helm-fkey-call-function helm-f6-data))

(defun helm-f6 ()
  (interactive)
  (helm :sources 'helm-f6-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f6*"))

;;------------------

(setq helm-f7-data
      '(("l" . ("[L]aTeX Math" "helm-insert-latex-math"))
        ("u" . ("[U]CS" "helm-ucs"))))

(defun helm-f7-candidates ()
  (mapcar 'cadr helm-f7-data))

(setq helm-f7-source
      '((name . "Insert")
        (candidates . helm-f7-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f7-call-function))))

(defun helm-f7-call-function (_)
  (helm-fkey-call-function helm-f7-data))

(defun helm-f7 ()
  (interactive)
  (helm :sources 'helm-f7-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f7*"))

;;------------------

(setq helm-f8-data
      '(("g" . ("[G]oogle Suggest" "helm-google-suggest"))
        ("p" . ("Emacs [P]rocess List" "helm-list-emacs-process"))
        ("s" . ("[S]urfraw" "helm-surfraw"))
        ("t" . ("[T]op" "helm-top"))
        ("w" . ("[W]orld time" "helm-world-time"))))

(defun helm-f8-candidates ()
  (mapcar 'cadr helm-f8-data))

(setq helm-f8-source
      '((name . "Misc")
        (candidates . helm-f8-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f8-call-function))))

(defun helm-f8-call-function (_)
  (helm-fkey-call-function helm-f8-data))

(defun helm-f8 ()
  (interactive)
  (helm :sources 'helm-f8-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f8*"))

;;------------------

(setq helm-f9-data
      '(("d" . ("Tumblr [D]ashboard" "tumblesocks-view-dashboard"))
        ("f" . ("News [F]eeds" "elfeed"))
        ("i" . ("[I]RC" "circe"))
        ;("m" . ("E-[M]ail" "mu4e"))
        ("t" . ("[T]etris" "tetris"))))

(defun helm-f9-candidates ()
  (mapcar 'cadr helm-f9-data))

(setq helm-f9-source
      '((name . "Distractions")
        (candidates . helm-f9-candidates)
        (candidate-transformer helm-fkey-prettify)
        (action ("Execute" . helm-f9-call-function))))

(defun helm-f9-call-function (_)
  (helm-fkey-call-function helm-f9-data))

(defun helm-f9 ()
  (interactive)
  (helm :sources 'helm-f9-source :keymap helm-fkey-keymap
        :prompt "Key: " :buffer "*helm-f9*"))

;;------------------
;; helm-pacman, helm-aur (compare helm-apt)
;; helm-dictionary
;; helm-project-persist, helm-projectile
;;
;; helm-etags-select
;; helm-semantic
;;------------------

(global-set-key (kbd "<f1>") 'helm-f1)
(global-set-key (kbd "<f2>") 'helm-f2)
(global-set-key (kbd "<f3>") 'helm-f3)
(global-set-key (kbd "<f4>") 'helm-f4)
(global-set-key (kbd "<f5>") 'helm-f5)
(global-set-key (kbd "<f6>") 'helm-f6)
(global-set-key (kbd "<f7>") 'helm-f7)
(global-set-key (kbd "<f8>") 'helm-f8)
(global-set-key (kbd "<f9>") 'helm-f9)

(provide 'helm-fkeys)
