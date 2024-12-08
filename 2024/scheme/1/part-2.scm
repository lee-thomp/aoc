#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 textual-ports))

(define (solve file)
  (call-with-input-file file
    (λ (port)
      ;; Solve here
      _)))

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
