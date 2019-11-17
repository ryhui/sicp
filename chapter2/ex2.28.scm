#lang scheme

(define (fringe xs)
  (cond ((pair? xs)
         (append (fringe (car xs)) (fringe (cdr xs))))
        ((not (null? xs))
         (list xs))
        ((null? xs)
         (list))))

; test

(define x (list (list 1 2) (list 3 4)))

(fringe x)
(fringe (list x x))
