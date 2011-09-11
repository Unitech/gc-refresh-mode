;;;;;;;;;;;;;;;;;;;;;; GC REFRESH v0.1 ;;;;;;;;;;;;;;;;;;;;
;;
;; GC Refresh by Strzelewicz Alexandre (http://apps.hemca.com)
;;
;; This plugin auto-reload Chromium tabs when you save a file
;;
;;;;;;;;;;;;;;;;;;;;; /!\ PLEASE /!\ ;;;;;;;;;;;;;;;;
;;
;;;;;;;; Contribute to : http://emacs.vote-system.com/ !
;;
;;;;;;;;;;;;;;;;;;;; INSTALLATION ;;;;;;;;;;;;;;;;;;;
;;
;; 1- You must be on a UNIX system
;; 2- chromium-browser must be accessible from the command line !
;;
;; If all of this is OK so you can install it :
;;
;; $ cd ~/.emacs.d/
;; $ git clone
;; $ emacs ~/.emacs.el
;; Add to your .emacs.el :
;;           (add-to-list 'load-path (expand-file-name "~/.emacs.d/gc-refresh"))
;;           (require 'gc-refresh-mode)
;;
;;;;;;;;;;;;;;;;;;;;;;; TODO ;;;;;;;;;;;;;;;;;;;;;
;;
;; TODO
;; - File parsing to get URL to refresh & open directly the right page
;;
;; MIT licensed
;;

(defvar gc-refresh-mode-hook nil)
(defvar gc-refresh-line-cmd nil)

(defun refresh-browser()
  (interactive)
  (save-buffer)
  (shell-command gc-refresh-line-cmd)
  )

(defun gc-refresh-mode ()
  "Minor mode for refreshing Chromium when saving file"
  (interactive)
  ;; Read URL to find on tabs
  (setq url (read-from-minibuffer "Url to refresh: " "http://"))
  ;; Concatenate URL with command
  (setq gc-refresh-line-cmd (concat "~/.emacs.d/gc-refresh/reload.py " url))
  ;; Start Chrome with URL given + with the remote option
  (shell-command (concat "chromium-browser " url " --remote-shell-port=9222"))
  ;; Rebind Save keys
  (define-key global-map "\C-x\C-s" 'refresh-browser)
  (print "GC Refresh mode is now READY --- C-x C-s is rebinded to refresh directly Chromium !")
  )

(provide 'gc-refresh-mode)
