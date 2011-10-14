;;; flymake-sass.el --- Flymake handler for sass files
;;
;;; Author: Steve Purcell <steve@sanityinc.com>
;;; URL: https://github.com/purcell/flymake-sass
;;; Version: DEV
;;
;;; Commentary:
;;
;; Usage:
;;   (require 'flymake-sass)
;;   (add-hook 'sass-mode-hook 'flymake-sass-load)
(require 'flymake)

(defvar flymake-sass-err-line-patterns '(("^Syntax error on line \\([0-9]+\\): \\(.*\\)$" nil 1 nil 2)))

;; Invoke utilities with '-c' to get syntax checking
(defun flymake-sass-init ()
  (list "sass" (list "-c" (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))))

;;;###autoload
(defun flymake-sass-load ()
  "Configure flymake mode to check the current buffer's sass syntax.

This function is designed to be called in `sass-mode-hook'; it
does not alter flymake's global configuration, so `flymake-mode'
alone will not suffice."
  (interactive)
  (set (make-local-variable 'flymake-allowed-file-name-masks) '(("." flymake-sass-init)))
  (set (make-local-variable 'flymake-err-line-patterns) flymake-sass-err-line-patterns)
  (if (executable-find "sass")
      (flymake-mode t)
    (message "Not enabling flymake: sass command not found")))


(provide 'flymake-sass)
;;; flymake-sass.el ends here
