#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 textual-ports)
	     (srfi srfi-1))

(define (report-safe? lst)
  ;; Offset list and subtract pairs, apply safety rules
  (let* ([differences (map - (cdr lst) lst)]
	 [safe-increasing? (every (λ (e) (member e '(1 2 3)))    differences)]
	 [safe-decreasing? (every (λ (e) (member e '(-1 -2 -3))) differences)])
    (or safe-increasing?
	safe-decreasing?)))

(define (solve file)
  (call-with-input-file file
    (λ (port)
      (let loop ([l (get-line port)]
		 [total 0])
	(if (eof-object? l)
	    total
	    (loop (get-line port)
		  ;; Increment total if report line is safe
		  (+ total
		     (if (report-safe?
			  ;; Split string, convert to numbers
			  (map string->number
			       (string-split l #\space)))
			 1 0))))))))

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
