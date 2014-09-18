(defvar dial-mode-alist
  '((?1 "1" 1 dial-digit) (?2 "2" 2 dial-digit) (?3 "3" 3 dial-digit)
    (?4 "4" 4 dial-digit) (?5 "5" 5 dial-digit) (?6 "6" 6 dial-digit)
    (?7 "7" 7 dial-digit) (?8 "8" 8 dial-digit) (?9 "9" 9 dial-digit)
    (?0 "0" 0 dial-digit) (?# "#" "\\#" dial-digit) (?* "*" "\\*" dial-digit)))

(defvar dial-mode-alist
  '((?q "c4" :c4 tone) (?2 "c#4" :c\#4 tone)
    (?w "d4" :d4 tone) (?3 "d#4" :d\#4 tone)
    (?e "e4" :e4 tone)
    (?r "f4" :f4 tone) (?5 "f#4" :f\#4 tone)
    (?t "g4" :g4 tone) (?6 "g#4" :g\#4 tone)
    (?y "a4" :a4 tone) (?7 "a#4" :a\#4 tone)
    (?u "b4" :b4 tone)
    (?i "c5" :c5 tone) (?9 "c#5" :c\#5 tone)
    (?o "d5" :d5 tone) (?0 "d#5" :d\#5 tone)
    (?p "e5" :e5 tone)
    (?\[ "f5" :f5 tone) (?= "f#5" :f\#5 tone)
    (?\] "g5" :g5 tone)

    (?z "c3" :c3 tone) (?s "c#3" :c\#3 tone)
    (?x "d3" :d3 tone) (?d "d#3" :d\#3 tone)
    (?c "e3" :e3 tone)
    (?v "f3" :f3 tone) (?g "f#3" :f\#3 tone)
    (?b "g3" :g3 tone) (?h "g#3" :g\#3 tone)
    (?n "a3" :a3 tone) (?j "a#3" :a\#3 tone)
    (?m "b3" :b3 tone)
    (?, "c4" :c4 tone) (?l "c#4" :c\#4 tone)
    (?. "d4" :d4 tone) (?\; "d#4" :d\#4 tone)
    (?/ "e4" :e4 tone)
    (?\\ "f#4" :f\#4 tone)))

(defun dial-process-key ()
  "Look up last insertion key hit"
  (interactive)
  (let* ((namespace "chiptune-covers.core")
         (key last-command-event)
         (alist (assoc key dial-mode-alist))
         (repr (cadr alist))
         (arg (nth 2 alist))
         (fun (nth 3 alist))
         (command (format "(%s %s)" fun arg)))
    (when fun (cider-eval-sync command namespace))
    (message (or repr "Unknown key"))))

(defvar dial-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [remap self-insert-command] 'dial-process-key)
    (define-key map (kbd "C-c C-q") 'bury-buffer)
    map)
  "This map passes self-insert commands on to a dedicated function.")

(define-derived-mode dial-mode fundamental-mode "Dial"
  "Dial numbers with the help of Overtone."
  (with-current-buffer (get-buffer "*dial*")
    (auto-save-mode -1)
    (buffer-disable-undo)))

(defun dial ()
  (interactive)
  (switch-to-buffer "*dial*")
  (dial-mode))
