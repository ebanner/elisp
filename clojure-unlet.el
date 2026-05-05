(defun clojure-wrap-in-def ()
  (paredit-wrap-round)
  (insert "def ")
  (paredit-forward-slurp-sexp)
  (paredit-backward-up)
  (paredit-forward)
  (paredit-forward)
  (paredit-backward))


(defun clojure-unlet ()
  (paredit-forward-down)
  (paredit-forward)
  (forward-char)

  (let* ((sexp-length (length (sexp-at-point)))
         (num-sexps (/ sexp-length 2)))

    (paredit-forward-down)

    (dotimes (_ num-sexps)
      (clojure-wrap-in-def)))

  (paredit-forward-down)
  (paredit-splice-sexp-killing-backward)
  (paredit-splice-sexp-killing-backward))


(defun count-sexps-in-region (beg end)
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (let ((count 0))
      (while (< (point) end)
        (forward-sexp 1)
        (setq count (1+ count)))

      (message (number-to-string count)))))
