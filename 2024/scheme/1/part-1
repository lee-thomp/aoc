#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 textual-ports))

(define (solve file)
  (call-with-input-file file
    (λ (port)
      (let loop ([c (get-line port)]
                 [left  '()]
                 [right '()])
        (if (eof-object? c)
            ;; Sum the differences between pairs after sorting both lists
            (apply + (map (compose abs -)
                          (sort left <)
                          (sort right <)))
            ;; Build up left and right list; /for me/ every line of input file
            ;; is 5 digits, 3 spaces, 5 digits and a newline.
            (loop (get-line port)
                  (cons (string->number (substring/read-only c 0 5)) left)
                  (cons (string->number (substring/read-only c 8 13)) right)))))))

;;; This works for /some/ sets of input, though I can't say why.  For me it
;;; works for around a 100 lines of input then differs from the solution above.
#;(define (solve-2 file)
  (call-with-input-file file
    (λ (port)
      (let loop ([c (get-line port)]
                 [left  0]
                 [right 0])
        (if (eof-object? c)
            (- left right)
            (loop (get-line port)
                  (+ (string->number (substring/read-only c 0 5)) left)
                  (+ (string->number (substring/read-only c 8 13)) right)))))))


(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
           (solve (cadr args)))))

;; Local Variables:
;; mode: scheme
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:
