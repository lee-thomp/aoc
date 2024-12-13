#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 textual-ports)
	     (ice-9 regex)
	     (srfi srfi-1))

(define (solve file)
  (call-with-input-file file
    (compose
     (λ (s)
       (error "solve me!"))
     ;; Slurp file into string
     get-string-all)))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
           (solve (cadr args)))))
