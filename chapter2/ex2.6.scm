#lang racket

(define zero (lambda (f) (lambda (x) x)))
; zero is defined as a function that returns another function
; which just returns its argument

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
; the function "add-1" is defined to return a function that
; takes in an argument f and returns a function ... I don't
; know how to continue!

; (add-1 zero)
; (lambda (f) (lambda (x) (f ((lambda (f) (lambda (x) x)) f) x)))
; (lambda (f) (lambda (x) (f x)))
; this is a function that returns another function which takes
; in an argument f and returns a function which takes in an argument
; x and applies the previous f to it

(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

; check:
; (add-1 one)
; (lambda (f) (lambda (x) (f ((lambda (f) (lambda (x) (f x))) f) x)))
; (lambda (f) (lambda (x) (f (f x))))