#lang scheme

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (counter f n accu)
    (if (zero? n)
        accu
        (counter f (- n 1) (compose f accu))))
  (counter f n (lambda (x) x)))

(define dx 0.00001)
(define (smooth f)
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

(define (smooth-n n)
  (repeated smooth n))

((smooth (lambda (x) (/ 1 x))) 0.3)
(((smooth-n 3) (lambda (x) (/ 1 x))) 0.3)