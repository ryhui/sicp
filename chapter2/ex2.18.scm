#lang scheme

(define (reverse xs)
  (if (null? xs)
      '()
      (append (reverse (cdr xs)) (list (car xs)))))

; test
(reverse (list 1 2 3))