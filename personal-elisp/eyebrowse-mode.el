(require 'dash)

;; --- variables -------------------------------------------------------------

(defcustom eyebrowse-lighter "¬_¬"
  "Lighter for the `eyebrowse-minor-mode'")

(defcustom eyebrowse-mode-line-style 'smart
  "The mode line style may be one of the following:

'hide: Don't show at all.

'smart: Hide when only one window config.

'always: Always show."
  ;; FIXME actually use this
  )

(defcustom eyebrowse-restore-point-p t
  "Restore point, too?
If t, restore point.")

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

;; --- internal functions ----------------------------------------------------

(defun eyebrowse-insert-in-window-config-list (element)
  "Insert ELEMENT in the list of window configs without
disrupting its sortedness."
  (setq eyebrowse-window-configs
        (-sort (lambda (a b) (< (car a) (car b)))
               (cons element eyebrowse-window-configs))))

(defun eyebrowse-update-window-config-element (old-element new-element)
  "Replace OLD-ELEMENT in the list of window configs with
NEW-ELEMENT"
  (setq eyebrowse-window-configs
        (-replace-at (-elem-index old-element eyebrowse-window-configs)
                     new-element eyebrowse-window-configs)))

(defun eyebrowse-save-window-config (slot)
  "Save the current window config to SLOT."
  (let* ((element (list slot (current-window-configuration) (point)))
         (match (assq slot eyebrowse-window-configs)))
    (if match
        (eyebrowse-update-window-config-element match element)
      (eyebrowse-insert-in-window-config-list element))))

(defun eyebrowse-load-window-config (slot)
  "Restore the window config from SLOT."
  (let ((match (assq slot eyebrowse-window-configs)))
    (when match
      (let ((window-config (cadr match))
            (point (caddr match)))
        (set-window-configuration window-config)
        (goto-char point)))))

(defun eyebrowse-delete-window-config (slot)
  "Remove the window config at SLOT."
  ;; TODO
)

(defun eyebrowse-update-mode-line ()
  "Redraw the relevant part of the mode line."
  ;; TODO
)

;; --- public functions ------------------------------------------------------

(defun eyebrowse-switch-to-window-config (slot)
  "Switch to the window config SLOT.  This will save the current
window config to `eyebrowse-current-slot' first, then switch. If
`eyebrowse-switch-back-and-forth-p' is t and
`eyebrowse-current-slot' equals SLOT, this will switch to the
last window config."
  (interactive)
  ;; FIXME make (interactive) do something
  (when (or (and eyebrowse-switch-back-and-forth-p (= eyebrowse-current-slot slot))
          (/= eyebrowse-current-slot slot))
    (eyebrowse-save-window-config eyebrowse-current-slot)
    (eyebrowse-load-window-config slot)
    (setq eyebrowse-last-slot eyebrowse-current-slot)
    (setq eyebrowse-current-slot slot)))

(defun eyebrowse-next-window-config ()
  "Switch to the next available window config.  If
`eyebrowse-wrap-around-p' is t, this will switch from the last to
the first one."
  (interactive)
  ;; TODO
)

(defun eyebrowse-prev-window-config ()
  "Switch to the previous available window config.  If
`eyebrowse-wrap-around-p' is t, this will switch from the first
to the last one."
  (interactive)
  ;; TODO
)

(defun eyebrowse-last-window-config ()
  "Switch to the last window config."
  (interactive)
  (eyebrowse-switch-to-window-config eyebrowse-last-slot))

(defun eyebrowse-close-window-config ()
  "Close the current window config and remove it from
`eyebrowse-window-configs'"
  (interactive)
  ;; TODO
)

(defun eyebrowse-setup-keys (variant)
  "Set up the key bindings for using eyebrowse. VARIANT is one of
the following:

'opinionated

'default"
  (interactive)
  ;; TODO
)

(provide 'eyebrowse)
