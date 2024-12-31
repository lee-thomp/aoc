#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 format)
	     (ice-9 textual-ports)
	     (ice-9 regex)
	     (srfi srfi-1))

(define (solve port)
    (let* ([input (get-string-all port)]
	   [line-length (1+ (string-index input #\newline 0))]
	   [→ "XMAS"]
	   [↘ (format #f "X.{~a}M.{~@*~a}A.{~@*~a}S" (1+ line-length))]
	   [↓ (format #f "X.{~a}M.{~@*~a}A.{~@*~a}S" line-length)]
	   [↙ (format #f "X.{~a}M.{~@*~a}A.{~@*~a}S" (1- line-length))]
	   [← "SAMX"]
	   [↖ (format #f "S.{~a}A.{~@*~a}M.{~@*~a}X" (1+ line-length))]
	   [↑ (format #f "S.{~a}A.{~@*~a}M.{~@*~a}X" line-length)]
	   [↗ (format #f "S.{~a}A.{~@*~a}M.{~@*~a}X" (1- line-length))]
	   [all (map make-regexp (list → ↘ ↓ ↙ ← ↖ ↑ ↗))])
      (let iter ([matches 0]
		 [rxs all]
		 [last (regexp-exec (car all) input 0)])
	(cond [last (iter (1+ matches)
			  rxs
			  (regexp-exec (car rxs) input (1+ (match:start last))))]
	      [(not (null? rxs)) (iter matches
				       (cdr rxs)
				       (regexp-exec (cadr rxs) input 0))]
	      [else matches]))))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
	   (call-with-input-file (cadr args)
	     solve))))
