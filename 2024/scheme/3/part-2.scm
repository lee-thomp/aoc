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
     ;; Finally get results of all muls and sum up
     (λ (ms)
       (apply + (map match->result ms)))
     ;; Unusual algorithm to create a list of only valid mul expression matches
     (λ (s)
       (let loop ([muls   (list-matches "mul\\(([0-9]+),([0-9]+)\\)" s)]
		  [dos    (list-matches "do\\(\\)" s)]
		  [don'ts (list-matches "don't\\(\\)" s)]
		  [valid-muls '()])
	 ;; If no more muls are left to select then return the list of valid
	 ;; muls
	 (cond [(null? muls) valid-muls]
	       ;; If the latest mul comes after a don't and a do then shave off
	       ;; that do and grab the next one
	       [(< (match:start (car dos))
		   (match:start (car don'ts))
		   (match:start (car muls)))
		(loop (cdr muls) (cdr dos) don'ts valid-muls)]
	       ;; The the latest mul comes after a don't then a do then select
	       ;; it and go the the next don't
	       [(< (match:start (car don'ts))
		   (match:start (car dos))
		   (match:start (car muls)))
		(loop (cdr muls) dos (cdr don'ts) (cons (car muls) valid-muls))]
	       ;; Mul expression between don't and do, don't add to list
	       [(< (match:start (car don'ts))
		   (match:start (car muls))
		   (match:start (car dos)))
		(loop (cdr muls) dos don'ts valid-muls)]
	       ;; If the current mul is between a do and a don't or is before
	       ;; both then select it
	       [else
		(loop (cdr muls) dos don'ts (cons (car muls) valid-muls))])))
     ;; This adds a load of 'do()'s and 'don't()'s to the end of the input so
     ;; the above algorithm works.  This is not very elegant
     (λ (s)
       (string-append s
		      (string-concatenate/shared
		       (make-list 100 "do()don't()"))))
     get-string-all)))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
           (solve (cadr args)))))
