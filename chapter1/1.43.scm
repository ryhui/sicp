#lang scheme

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (counter f n accu)
    (if (zero? n)
        accu
        (counter f (- n 1) (compose f accu))))
  (counter f n (lambda (x) x)))

                 
; test
(define inc (lambda (x) (+ 1 x)))
((repeated inc 5) 1)

(define square (lambda (x) (* x x)))
((repeated square 2) 5)