(setq TeX-quote-after-quote t
      TeX-parse-self t
      TeX-view-program-list '(("llpp" "llpp %o"))
      TeX-view-program-selection '(((output-dvi style-pstricks)
                                    "dvips and gv")
                                   (output-dvi "xdvi")
                                   (output-pdf "llpp")
                                   (output-html "xdg-open")))
(add-hook 'LaTeX-mode-hook '(lambda () (TeX-global-PDF-mode 1)))
(add-hook 'LaTeX-mode-hook 'latex/setup-keybinds)
(autoload 'latex/section-regexp "latex-extra" "LaTeX section regexp" t)
(defun wasa-extend-hs-modes-alist ()
  (add-to-list 'hs-special-modes-alist
               `(latex-mode ,(latex/section-regexp) nil "%"
                            (lambda (arg) (latex/next-section 1)
                              (skip-chars-backward " \t\n")) nil)))
(add-hook 'LaTeX-mode-hook 'wasa-extend-hs-modes-alist)

(defun wasa-turn-on-pretty-symbols-mode ()
  (pretty-symbols-mode 1)
  (font-latex-setup)
  (font-lock-fontify-buffer))
(setq TeX-install-font-lock 'wasa-turn-on-pretty-symbols-mode)
(add-hook 'LaTeX-mode-hook 'wasa-turn-on-pretty-symbols-mode)

(setq LaTeX-section-hook '(wasa-LaTeX-section-heading
                           LaTeX-section-title
                           LaTeX-section-section))

(defun wasa-LaTeX-section-heading ()
  "Hook to prompt for LaTeX section name.
Insert this hook into `LaTeX-section-hook' to allow the user to change
the name of the sectioning command inserted with `\\[LaTeX-section]'."
  (let ((string (completing-read
		 (concat "Level: (default " name ") ")
		 LaTeX-section-list
		 nil nil name)))
    ; Update name
    (if (not (zerop (length string)))
	(setq name string))
    ; Update level
    (setq level (LaTeX-section-level name))))

(defun wasa-LaTeX-environment (arg)
  "Make LaTeX environment (\\begin{...}-\\end{...} pair).
With optional ARG, modify current environment.

It may be customized with the following variables:

`LaTeX-default-environment'       Your favorite environment.
`LaTeX-default-style'             Your favorite document class.
`LaTeX-default-options'           Your favorite document class options.
`LaTeX-float'                     Where you want figures and tables to float.
`LaTeX-table-label'               Your prefix to labels in tables.
`LaTeX-figure-label'              Your prefix to labels in figures.
`LaTeX-default-format'            Format for array and tabular.
`LaTeX-default-width'             Width for minipage and tabular*.
`LaTeX-default-position'          Position for array and tabular."

  (interactive "*P")
  (let ((environment (completing-read (concat "Environment type: (default "
					       (if (TeX-near-bobp)
						   "document"
						 LaTeX-default-environment)
					       ") ")
				      (LaTeX-environment-list) nil t nil
				      'LaTeX-environment-history LaTeX-default-environment)))
    ;; Get default
    (cond ((and (zerop (length environment))
		(TeX-near-bobp))
	   (setq environment "document"))
	  ((zerop (length environment))
	   (setq environment LaTeX-default-environment))
	  (t
	   (setq LaTeX-default-environment environment)))

    (let ((entry (assoc environment (LaTeX-environment-list))))
      (if (null entry)
	  (LaTeX-add-environments (list environment)))

      (if arg
	  (LaTeX-modify-environment environment)
	(LaTeX-environment-menu environment)))))

(defun wasa-TeX-command-master (&optional override-confirm)
  "Run command on the current document.

If a prefix argument OVERRIDE-CONFIRM is given, confirmation will
depend on it being positive instead of the entry in `TeX-command-list'."
  (interactive "P")
  (TeX-command (wasa-TeX-command-query (TeX-master-file)) 'TeX-master-file
	       override-confirm))


(defun wasa-TeX-command-query (name)
  "Query the user for what TeX command to use."
  (let* ((default
	   (cond ((if (string-equal name TeX-region)
		      (TeX-check-files (concat name "." (TeX-output-extension))
				       (list name)
				       TeX-file-extensions)
		    (TeX-save-document (TeX-master-file)))
		  TeX-command-default)
		 ((and (memq major-mode '(doctex-mode latex-mode))
		       ;; Want to know if bib file is newer than .bbl
		       ;; We don't care whether the bib files are open in emacs
		       (TeX-check-files (concat name ".bbl")
					(mapcar 'car
						(LaTeX-bibliography-list))
					(append BibTeX-file-extensions
						TeX-Biber-file-extensions)))
		  ;; We should check for bst files here as well.
		  (if LaTeX-using-Biber TeX-command-Biber TeX-command-BibTeX))
		 ((TeX-process-get-variable name
					    'TeX-command-next
					    TeX-command-Show))
		 (TeX-command-Show)))
         (completion-ignore-case t)
         (answer (or TeX-command-force
                     (completing-read
                      (concat "Command: (default " default ") ")
                      (TeX-mode-specific-command-list major-mode) nil t
                      default 'TeX-command-history))))
    ;; If the answer is "latex" it will not be expanded to "LaTeX"
    (setq answer (car-safe (TeX-assoc answer TeX-command-list)))
    (if (and answer
             (not (string-equal answer "")))
        answer
      default)))

(defun wasa-LaTeX-hook ()
  (local-set-key (kbd "C-c C-e") 'wasa-LaTeX-environment)
  (local-set-key (kbd "C-c C-c") 'wasa-TeX-command-master))
(add-hook 'LaTeX-mode-hook 'wasa-LaTeX-hook)

(provide 'wasa-auctex)
