#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 textual-ports)
	     (srfi srfi-1))

(define (solve file)
  (call-with-input-file file
    (λ (port)
      _)))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
           (solve (cadr args)))))
