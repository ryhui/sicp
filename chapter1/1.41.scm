#lang scheme

(define (double f)
  (lambda (x) (f (f x))))

(define (inc x)
  (+ x 1))

((double inc) 10)

(((double (double double)) inc) 5)

; (double double): apply procedure 2*2 times
; (double (double double)): apply procedure 4*4 times
; ((double (double double)) inc): increase by 16