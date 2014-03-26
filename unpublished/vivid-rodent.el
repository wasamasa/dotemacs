;;; vivid-rodent.el --- Pick a color with your mouse

;; Copyright (C) 2014 Vasilij Schneidermann <v.schneidermann@gmail.com>

;; Author: Vasilij Schneidermann <v.schneidermann@gmail.com>
;; URL: https://github.com/wasamasa/vivid-rodent
;; Version: 0.0.1
;; Package-Requires: ((color "0") (face-remap "0") (emacs "23"))
;; Keywords: convenience face mouse

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This package defines a major mode that allows you to pick a color
;; with your mouse.  It is modeled after <http://colourco.de/>.

;; See the README for more info:
;; https://github.com/wasamasa/vivid-rodent

;;; Code:

(require 'color)
(require 'face-remap)

;; --- variables -------------------------------------------------------------

(defgroup vivid-rodent nil
  "Mouse-based color selection."
  :group 'convenience
  :prefix "vivid-rodent-")

(defcustom vivid-rodent-initial-saturation 0.6
  "Initial saturation value."
  :type 'float
  :group 'vivid-rodent)

(defcustom vivid-rodent-scroll-step 0.01
  "The amount by which the saturation changes per key event."
  :type 'float
  :group 'vivid-rodent)

(defvar vivid-rodent-hue 0
  "Current hue value.")

(defvar vivid-rodent-saturation vivid-rodent-initial-saturation
  "Current saturation value.")

(defvar vivid-rodent-luminance 0
  "Current luminance value.")

;; --- helper functions ------------------------------------------------------

(defun vivid-rodent-relative-position (value lower-bound upper-bound)
  "Derive the relative position of an integer VALUE.
LOWER-BOUND and UPPER-BOUND specify the boundary."
  (/ (- (min (max value lower-bound) upper-bound) lower-bound)
     (float (- upper-bound lower-bound))))

;; --- public functions ------------------------------------------------------

(define-derived-mode vivid-rodent-mode special-mode "🐭"
  "Pick a color interactively with your mouse.")

;;;###autoload
(defun vivid-rodent ()
  "Pick a color interactively with your mouse."
  (interactive)
  (message "Move mouse to select hue and brightness, scroll to select saturation, double-click to pick color.")
  ;; attempt #1
  ;; (switch-to-buffer (get-buffer-create "*vivid rodent*"))
  ;; attempt #2
  ;; (display-buffer (get-buffer-create "*vivid rodent*"))
  ;; attempt #3
  (let ((buffer (get-buffer-create "*vivid rodent*")))
    (select-window (or (get-buffer-window buffer) (display-buffer buffer))))
  (vivid-rodent-mode)
  (catch 'mouse-position
    (track-mouse
      (while t
        (let* ((event (read-event))
               (event-type (event-basic-type event))
               (event-clicks (event-click-count event))
               (mouse-position (cdr (mouse-pixel-position)))
               (mouse-x (car mouse-position))
               (mouse-y (cdr mouse-position))
               (window-edges (window-inside-pixel-edges))
               (left-edge (car window-edges))
               (top-edge (cadr window-edges))
               (right-edge (nth 2 window-edges))
               (bottom-edge (nth 3 window-edges))
               (rgb-value (color-hsl-to-rgb vivid-rodent-hue
                                            vivid-rodent-saturation
                                            vivid-rodent-luminance))
               (rgb-code (color-rgb-to-hex (car rgb-value) (cadr rgb-value)
                                           (nth 2 rgb-value))))
          (cond
           ((mouse-movement-p event)
            (setq vivid-rodent-hue
                  (vivid-rodent-relative-position mouse-x left-edge right-edge))
            (setq vivid-rodent-luminance
                  (vivid-rodent-relative-position mouse-y top-edge bottom-edge))
            (buffer-face-set :background rgb-code))
           ((or (equal event-type 'mouse-4)
                (and (numberp event-type) (= event-type ?+)))
            (setq vivid-rodent-saturation (min (+ vivid-rodent-saturation
                                                  vivid-rodent-scroll-step) 1))
            (buffer-face-set :background rgb-code))
           ((or (equal event-type 'mouse-5)
                (and (numberp event-type) (= event-type ?-)))
            (setq vivid-rodent-saturation (max (- vivid-rodent-saturation
                                                  vivid-rodent-scroll-step) 0))
            (buffer-face-set :background rgb-code))
           ((and (equal event-type 'mouse-1) (= event-clicks 1))
            (throw 'mouse-position
                   (progn
                     (buffer-face-set nil)
                     (kill-new rgb-code)
                     (message "%s saved to kill ring" rgb-code))))))))))

(provide 'vivid-rodent)

;;; vivid-rodent.el ends here
