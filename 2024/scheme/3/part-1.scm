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
    (compose
     ;; Map helper function over list of match structures, sum up results
     (λ (matches)
       (apply + (map match->result matches)))
     ;; Get all matches
     (λ (s)
       (list-matches
	(make-regexp "mul\\(([0-9]+),([0-9]+)\\)")
	s))
     ;; Slurp file into string
     get-string-all)))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
           (solve (cadr args)))))
