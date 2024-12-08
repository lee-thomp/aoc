#!/usr/bin/env -S guile -e main -s
!#
(use-modules (ice-9 textual-ports))

(define (solve file)
  (call-with-input-file file
    (λ (port)
      (let loop ([c (get-line port)]
                 [left  '()]
                 [right '()])
        (if (eof-object? c)
	    ;; Map filter over right list for what appears in left, multiply
	    ;; left element by count in right, then sum up list.
            (apply +
		   (map
		    (λ (l)
		      (* l (length (filter (λ (r)
					     (= r l))
					   right))))
		    left))
	    ;; Build up left and right list; /for me/ every line of input file
            ;; is 5 digits, 3 spaces, 5 digits and a newline.
            (loop (get-line port)
                  (cons (string->number (substring/read-only c 0 5)) left)
                  (cons (string->number (substring/read-only c 8 13)) right)))))))

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
