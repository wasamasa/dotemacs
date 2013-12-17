;;; ac-company.el --- Use Company Backends for Auto-Complete.

;; Copyright (C) 2009, 2010  Taiki SUGAWARA

;; Author: Taiki SUGAWARA <buzz.taiki@gmail.com>
;; URL: http://github.com/buzztaiki/auto-complete
;; Keywords: convenience
;; Version: 0.2

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; For example, if you want to use company-elisp for auto-complete,
;; put following to your .emacs:
;;
;; (require 'ac-company)
;; (ac-company-define-source ac-source-company-elisp company-elisp)
;; (add-hook 'emacs-lisp-mode-hook
;;        (lambda () 
;;          (add-to-list 'ac-sources 'ac-source-company-elisp)))
;;
;; You can overrides attributes. For example, if you want to add
;; symbol to ac-source-company-elisp, put following:
;;
;; (ac-company-define-source ac-source-company-elisp company-elisp
;;                           (symbol . "s"))


;;; Code:

(require 'auto-complete)
(require 'company nil t)

(defmacro ac-company-define-source (name backend &rest overrides)
  "Define auto-complete source NAME from company BACKEND.
When OVERRIDES is specified, OVERRIDES is prepend to original source."
  `(defvar ,name
     '(,@overrides
       (candidates . (ac-company-candidates ',backend))
       (prefix . (ac-company-prefix ',backend))
       (document . (lambda (item) (ac-company-document ',backend item))))))
  
(defun ac-company-prefix (backend)
  (require backend nil t)
  (when (fboundp backend)
    (let ((prefix (funcall backend 'prefix)))
      (when (stringp prefix) 
	(- (point) (length prefix))))))

(defun ac-company-candidates (backend)
  (funcall backend 'candidates ac-prefix))

(defun ac-company-meta-as-document (backend item)
  (funcall backend 'meta item))

(defun ac-company-doc-buffer-as-document (backend item)
  (with-current-buffer (funcall backend 'doc-buffer item)
    (buffer-string)))

(defun ac-company-document (backend item)
  (or (ac-company-doc-buffer-as-document backend item)
      (ac-company-meta-as-document backend item)))

(provide 'ac-company)
;;; ac-company.el ends here