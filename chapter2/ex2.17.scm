#lang scheme

(define (last-pair xs)
  (if (null? (cdr xs))
      (car xs)
      (last-pair (cdr xs))))

; test
(define x (list 1 4 9 16 25))
(last-pair x)