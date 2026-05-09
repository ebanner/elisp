(defun wrap-in-def ()
  (paredit-wrap-round)
  (insert "def ")
  (paredit-forward-slurp-sexp)
  (paredit-backward-up)
  (paredit-forward)
  (paredit-forward)
  (paredit-backward))

(defun clojure-unlet ()
  "Turns a `(let [v1 e1 ... vn en] body)` into `(def v1 e1) ... (def vn en) body`"
  (interactive)

  (paredit-forward-down)
  (paredit-forward)
  (forward-char)

  (let* ((sexp-length (length (sexp-at-point)))
         (num-sexps (/ sexp-length 2)))

    (paredit-forward-down)

    (dotimes (_ num-sexps)
      (wrap-in-def)))

  (paredit-forward-down)
  (paredit-splice-sexp-killing-backward)
  (paredit-splice-sexp-killing-backward))

(defun count-sexps-in-region (beg end)
  (save-excursion
    (goto-char beg)
    (let ((count 0))
      (while (< (point) end)
        (forward-sexp 1)
        (setq count (1+ count)))
      count)))

(defun clojure-relet (beg end)
  "Turns a `(def v1 e1) ... (def vn en) body` into `(let [v1 e1 ... vn en] body)`"
  (interactive "r")

  (let* ((num-sexps (count-sexps-in-region beg end))
         (num-defs (1- num-sexps)))

    (deactivate-mark)

    (paredit-wrap-round)
    (insert "let ")
    (paredit-open-square)

    (dotimes (_ (* num-defs 2))
      (paredit-forward-slurp-sexp))

    (paredit-forward-down)

    (dotimes (_ num-defs)
      (paredit-forward-kill-word)
      (paredit-delete-char)
      (paredit-backward-up)
      (paredit-forward)
      (paredit-forward)
      (paredit-backward))))

