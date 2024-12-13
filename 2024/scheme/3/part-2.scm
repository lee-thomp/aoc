#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 textual-ports)
	     (ice-9 regex)
	     (srfi srfi-1))

(define (match->result m)
  (* (string->number (match:substring m 1))
     (string->number (match:substring m 2))))

(define (solve file)
  (call-with-input-file file
    _))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
           (solve (cadr args)))))
