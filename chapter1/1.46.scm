#lang scheme

(define (iterative-improve good-enough? improve)
  (define (assess guess)
    (if (good-enough? guess)
        guess
        (assess (improve guess))))
  (lambda (x) (assess x)))

(define tol 0.00001)
(define (fix f)
  (lambda (x) 
    (< (abs (- x (f x))) tol)))

(define (sqrt n)
  ((iterative-improve
   (fix (lambda (x) (/ n x)))
   (lambda (x) (/ (+ x (/ n x)) 2))) 1.0))

(define (fixed-point f first-guess)
  ((iterative-improve
    (fix f)
    f) first-guess))

; test: (fixed-point (lambda (x) (* x x)) 0.1)
    