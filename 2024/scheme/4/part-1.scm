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
	   [↗ (format #f "S.{~a}A.{~@*~a}M.{~@*~a}X" (1- line-length))])
      (apply +
	     (map (compose
		   length
		   (λ (r) (list-matches r input)))
		  (list → ↘ ↓ ↙ ← ↖ ↑ ↗)))))

(define (main args)
  (exit
   (format #t "answer: ~s~%"
           ;; `args' always name script first
	   (call-with-input-file (cadr args)
	     solve))))
