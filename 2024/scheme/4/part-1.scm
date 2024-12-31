#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 format)
	     (ice-9 textual-ports)
	     (ice-9 regex)
	     (srfi srfi-1))

(define (solve port)
    (let* ([input (get-string-all port)]
	   ;; Detect line length to construct regexes below
	   [line-length (string-index input #\newline 0)]
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
	      ;; Return count of matches when no more matches are left and this
	      ;; is the last regex
	      [(null? (cdr rxs)) matches]
	      ;; If there was no match but there are still regexes then move to
	      ;; the next regex and reset to the start of the input
	      [else (iter matches
			  (cdr rxs)
			  (regexp-exec (cadr rxs) input 0))]))))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
	   (call-with-input-file (cadr args)
	     solve))))
