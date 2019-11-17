#lang scheme

(define (reverse xs)
  (if (null? xs)
      '()
      (append (reverse (cdr xs)) (list (car xs)))))

(define (deep-reverse xs)
  (if (list? xs)
      (if (< 1 (length xs))
          (list (deep-reverse (cadr xs)) (deep-reverse (car xs)))
          xs)
      xs))
  
;test
(define x (list (list 1 2) (list 3 4)))

x
(reverse x)
(deep-reverse x)