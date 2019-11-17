#lang scheme

(define (cons x y)
  (lambda (m) (m x y)))
; returns a function that takes in an additional function and
; apply it to x and y

(define (car z)
  (z (lambda (p q) p)))
; car takes in a function and applies it to a function that
; always returns its first argument

(define (cdr z)
  (z (lambda (p q) q)))

;(car (cons x y))
;((cons x y) (lambda (p q) p))
;((lambda (m) (m x y)) (lambda (p q) q))
;((lambda (p q) q) x y)
;x

; similar for (cdr (cons x y))
