(require 'dash)

;; --- variables -------------------------------------------------------------

(defcustom eyebrowse-lighter "¬_¬"
  "Lighter for the `eyebrowse-minor-mode'")

(defcustom eyebrowse-mode-line-position 'right
  "Position of the mode line indicator.
It can be either 'left or 'right")

(defcustom eyebrowse-mode-line-style 'auto-hide
  "The mode line style may be one of the following:

'ninja: Don't show at all.

'auto-hide: Hide when only one window config.

'always: Always show.")

(defcustom eyebrowse-restore-point-p t
  "Restore point, too?
If t, restore point.")

(defcustom eyebrowse-frame-local-p nil
  "Should eyebrowse use an indicator per frame?
If t, use an indicator per frame.
If nil, use one indicator for all frames.")

(defcustom eyebrowse-wrap-around-p nil
  "Wrap around when switching to the next/previous window config?
If t, wrap around.")

(defcustom eyebrowse-switch-back-and-forth-p nil
  "When switching to the same window config as
`eyebrowse-current-window-config', do switch to
`eyebrowse-last-window-config' or not?
If t, switch back and forth.")

(defvar eyebrowse-last-slot 1
  "Internal variable storing the last window config slot.")

(defvar eyebrowse-current-slot 1
  "Internal variable storing the current window config slot.")

(defvar eyebrowse-window-configs nil
  "Internal variable storing all window configs.")

;; --- helpers ---------------------------------------------------------------

(defun eyebrowse-insert-in-sorted-list (element list)
  "Insert ELEMENT in LIST without disrupting its sortedness."
  ;; TODO
)

(defun eyebrowse-update-list-element (old-element new-element list)
  "Replace OLD-ELEMENT in LIST with NEW-ELEMENT"
  ;; TODO
)

(defun eyebrowse-save-window-config (slot)
  "Save the current window config to SLOT.")

(defun eyebrowse-load-window-config (slot)
  "Restore the window config from SLOT.")

(defun eyebrowse-switch-to-window-config (slot)
  "Switch to the window config SLOT.  This will save the current
window config to `eyebrowse-current-slot' first, then switch. If
`eyebrowse-switch-back-and-forth-p' is t, this will switch to the
last window config.")

(defun eyebrowse-next-window-config ()
  (interactive)
  "Switch to the next available window config.  If
`eyebrowse-wrap-around-p' is t, this will switch from the last to
the first one.")

(defun eyebrowse-prev-window-config ()
  (interactive)
  "Switch to the previous available window config.  If
`eyebrowse-wrap-around-p' is t, this will switch from the first
to the last one.")

(defun eyebrowse-last-window-config ()
  (interactive)
  "Switch to the last window config.")

(defun eyebrowse-delete-window-config (slot)
  "Remove the window config at SLOT.")

(defun eyebrowse-close-window-config ()
  (interactive)
  "Close the current window config and remove it from
`eyebrowse-window-configs'")

(defun eyebrowse-update-mode-line ()
  "Redraw the relevant part of the mode line.")

;; bind M-1..9 to (lambda () (interactive) (eyebrowse-switch-to-window-config 1..9))
