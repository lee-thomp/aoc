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
     (λ (s)
       (let* ([muls   (list-matches "mul\\(([0-9]+),([0-9]+)\\)" s)]
	      [dos    (list-matches "do\\(\\)" s)]
	      [don'ts (list-matches "don't\\(\\)" s)])
	 ;; The idea I've got is to now build up a list of 'valid' muls by
	 ;; iterating over the list of muls, consing them to some other list if
	 ;; their index into the string is more than a do and less than a don't.
	 (error "solve me!")))
     get-string-all)))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
           (solve (cadr args)))))
