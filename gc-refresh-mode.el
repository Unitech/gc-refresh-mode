;;; lisp-mnt.el --- minor mode for Emacs Lisp maintainers
     
;; Copyright (C) 1992 Free Software Foundation, Inc.
     
;; Author: Strzelewicz Alexandre <strzelewicz.alexandre@gmail.com>
;; Maintainer: Strzelewicz Alexandre <strzelewicz.alexandre@gmail.com>
;; Created: 15 Sept 2011
;; Version: 1.0
;; Keywords: Refresh Chrome
;; This file is part of GNU Emacs.
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

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
  (setq gc-refresh-line-cmd (concat "~/.emacs.d/gc-refresh-mode/reload.py " url))
  ;; Start Chrome with URL given + with the remote option
  (shell-command (concat "chromium-browser " url " --remote-shell-port=9222"))
  ;; Rebind Save keys
  (define-key global-map "\C-x\C-s" 'refresh-browser)
  (print "GC Refresh mode is now READY --- C-x C-s is rebinded to refresh directly Chromium !")
  )

(provide 'gc-refresh-mode)
