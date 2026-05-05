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
